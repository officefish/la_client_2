package com.la.mvc.controller.achieves 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.CardEvent;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.mvc.view.achieves.AchieveSlot;
	import com.la.mvc.view.achieves.EmptyAchieveSlot;
	import com.la.mvc.view.card.AchieveCard;
	import com.la.mvc.view.scene.IScene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DragAchieveSlotCommand extends Command 
	{
		[Inject]
		public var event:CardEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='achieves')]
		public var achieves:AchieveBrowser;
				
		private var slot:AchieveSlot;
		private var emptySlot:EmptyAchieveSlot;
		private var position:Point;
		private var distance:int;
		private var card:AchieveCard;
		private var copy:Sprite;
		
		
		
		override public function execute():void 
		{
			distance = achieves.y + 120;
			
			slot = event.data.slot;
			emptySlot = slot.parent as EmptyAchieveSlot;
			
			card = achieves.getAchieveCardById(slot.achieveId);
			copy = card.getCopy();
			
			position = new Point(slot.x, slot.y);
			position = slot.parent.localToGlobal(position);
			
			slot.x = position.x;
			slot.y = position.y;
			
			scene.placeCard(slot);
			slot.startDrag();
			
			addSlotListeners();
		}	
		
		private function addSlotListeners () :void {
			slot.addEventListener(MouseEvent.MOUSE_UP, onSlotMouseUp);
			contextView.stage.addEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave); 
			contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, onSlotModeMouseMove);
		}
		
		private function destroySlotListeners () :void {
			slot.removeEventListener(MouseEvent.MOUSE_UP, onSlotMouseUp);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave); 
			contextView.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onSlotModeMouseMove);

		}
		
		private function onSlotModeMouseMove(event:MouseEvent) :void {
			if (contextView.mouseY > distance) {
				slot.stopDrag();
				destroySlotListeners();
				var slotPosition:Point = new Point(contextView.mouseX, contextView.mouseY);
				slotPosition.x -= copy.width / 2;
				slotPosition.y -= copy.height / 2;
				copy.x = slotPosition.x;
				copy.y = slotPosition.y;
				scene.endPlaceCard();
				scene.placeCard(copy);
				copy.startDrag();
				addCardListeners();
			}
		}
		
		private function onSlotModeMouseLeave(event:Event):void {
			slot.stopDrag();
			destroySlotListeners();
			TweenLite.to (slot, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
		}
		
		private function onSlotMouseUp(event:MouseEvent) :void {
			slot.stopDrag();
			destroySlotListeners();
			TweenLite.to (slot, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
		}
		
		private function onBackComplete() :void {
			slot.x = 0;
			slot.y = 0;
			emptySlot.addChild(slot);
		}
		
		private function addCardListeners() :void {
			copy.addEventListener(MouseEvent.MOUSE_UP, onCardMouseUp);
			contextView.stage.addEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave); 
			contextView.stage.addEventListener(MouseEvent.MOUSE_MOVE, onCardModeMouseMove);

		}
		
		private function destroyCardListeners() :void {
			copy.removeEventListener(MouseEvent.MOUSE_UP, onCardMouseUp);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave); 
			contextView.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onCardModeMouseMove);

		}
		
		private function onCardModeMouseMove(event:MouseEvent) :void {
			if (contextView.mouseY < distance) {
				destroyCardListeners();
				copy.stopDrag();
				var slotPosition:Point = new Point(contextView.mouseX, contextView.mouseY);
				slotPosition.x -= 35;
				slotPosition.y -= 35;
				slot.x = slotPosition.x;
				slot.y = slotPosition.y;
				scene.endPlaceCard();
				scene.placeCard(slot);
				slot.startDrag();
				addSlotListeners();
			}
		}
		
		private function onCardModeMouseLeave(event:Event) :void {
			backCard();
		}
		
		private function onCardMouseUp(event:MouseEvent) :void {
			backCard();
		}
		
		private function backCard () :void {
			destroyCardListeners();
			if (card.stage) {
				var cardPosition:Point = new Point(card.x, card.y);
				cardPosition = card.parent.localToGlobal(cardPosition);
				TweenLite.to(copy, 0.5,{x:cardPosition.x, y:cardPosition.y, ease:Expo.easeOut, onComplete:onBackCardComplete});
				
				
			} else {
				scene.endPlaceCard();
				card.unblock();
			}
		}
		
		private function onBackCardComplete() :void {
			scene.endPlaceCard();
			card.unblock();
		}
	}

}