package com.la.mvc.controller.achieves 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.CardEvent;
	import com.la.mvc.model.AchieveData;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.mvc.view.achieves.AchieveSlot;
	import com.la.mvc.view.achieves.EmptyAchieveSlot;
	import com.la.mvc.view.card.AchieveCard;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DragAchieveCardCommand extends Command 
	{
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject]
		public var event:CardEvent;
		
		private var cardCopy:Sprite;
		private var position:Point;
		private var card:AchieveCard;
		private var slot:AchieveSlot;
		
		[Inject (name='achieves')]
		public var achieves:AchieveBrowser;
		
		private var distance:int;
		
		override public function execute():void 
		{
			distance = achieves.y + 120;
			
			card = event.data.card;
			cardCopy = card.getCopy();
			
			slot = new AchieveSlot(card.getData());
			
			position = new Point(card.x, card.y); 
			position= card.parent.localToGlobal(position);
			
			cardCopy.x = position.x;
			cardCopy.y = position.y;
			
			contextView.addChild (scene as DisplayObject);
			scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.placeCard (cardCopy);
			cardCopy.startDrag ();
			card.block();
			
			addCardListeners();
		}
		
		private function onCardMouseMove(event:MouseEvent) :void {
			if (contextView.mouseY < distance) {
				cardCopy.stopDrag();
				destroyCardListeners();
				scene.endPlaceCard();
				var slotPosition:Point = new Point(contextView.mouseX, contextView.mouseY);
				slotPosition.x -= 35;
				slotPosition.y -= 35;
				slot.x = slotPosition.x;
				slot.y = slotPosition.y;
				slot.startDrag();
				scene.placeCard(slot);
				addSlotListeners();

			}
		}
		
		private function onMouseUp (event:MouseEvent) :void {
			backCard();
			destroyCardListeners();
		}
		
		
		private function onCardModeMouseLeave(event:Event) :void {
			backCard();
			destroyCardListeners();
		}
		
		private function backCard () :void {
			cardCopy.stopDrag();
			var copyPosition:Point = new Point (cardCopy.x, cardCopy.y);
			copyPosition = cardCopy.parent.localToGlobal(copyPosition);

			if (copyPosition.x == position.x && copyPosition.y == position.y) {
				card.unblock();
				scene.endPlaceCard();
			} else { 
				TweenLite.to (cardCopy, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
			}
		}
		
		private function onBackComplete () :void {
			card.unblock();
			cardCopy.stopDrag();
			scene.endPlaceCard();
		}
		
		private function destroyCardListeners () :void {
			cardCopy.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave);
			contextView.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onCardMouseMove);
		}
		
		private function addCardListeners () :void {
			cardCopy.addEventListener (MouseEvent.MOUSE_UP, onMouseUp); 
			contextView.stage.addEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave); 
			contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, onCardMouseMove);
		}
		
		private function addSlotListeners() :void {
			contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlotMouseMove);
			slot.addEventListener(MouseEvent.MOUSE_UP, onSlotMouseUp);
		}
		
		private function onSlotMouseUp (event:MouseEvent) :void {
			slot.stopDrag();
			destroySlotListeners();
			if (event.target.dropTarget is EmptyAchieveSlot) {
				slot.x = 0;
				slot.y = 0;
				(event.target.dropTarget as EmptyAchieveSlot).addChild(slot);
				Mouse.cursor = MouseCursor.AUTO; 

			} else {
				var slotPosition:Point = new Point(contextView.mouseX, contextView.mouseY);
				slotPosition.x -= cardCopy.width / 2;
				slotPosition.y -= cardCopy.height / 2;
				cardCopy.x = slotPosition.x;
				cardCopy.y = slotPosition.y;
				scene.endPlaceCard();
				scene.placeCard(cardCopy);
				TweenLite.to (cardCopy, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
			}
		}
		
		private function destroySlotListeners() :void {
			contextView.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlotMouseMove);
			slot.removeEventListener(MouseEvent.MOUSE_UP, onSlotMouseUp);
		}
		
		private function onSlotMouseMove(event:MouseEvent) :void {
			if (contextView.mouseY > distance) {
				slot.stopDrag();
				destroySlotListeners();
				scene.endPlaceCard();
				var slotPosition:Point = new Point(contextView.mouseX, contextView.mouseY);
				slotPosition.x -= cardCopy.width / 2;
				slotPosition.y -= cardCopy.height / 2;
				cardCopy.x = slotPosition.x;
				cardCopy.y = slotPosition.y;
				cardCopy.startDrag();
				scene.placeCard(cardCopy);
				addCardListeners();
			}
		}
	}

}