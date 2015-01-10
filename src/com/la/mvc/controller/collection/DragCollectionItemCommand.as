package com.la.mvc.controller.collection 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.CollectionCardData;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.view.card.CollectionCard;
	import com.la.mvc.view.collection.DeckItemSlot;
	import com.la.mvc.view.collection.ICollection;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DragCollectionItemCommand extends Command 
	{
			
		[Inject (name='collectionModel')]
		public var model:CollectionModel;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		private var position:Point;
		private var cardCopy:CollectionCard;
		
		[Inject (name='collection')]
		public var collection:ICollection;  
		
		private var dropContainer:Sprite;
		private var slot:DeckItemSlot;
		
		
		override public function execute():void 
		{
			var card:CollectionCard = model.collectionCard;
			
			var data:CollectionCardData = card.getCardData();
			cardCopy = new CollectionCard(data, false);
			
			position = new Point(card.x, card.y); 
			position= card.parent.localToGlobal(position);
			
			cardCopy.x = position.x;
			cardCopy.y = position.y;
			
			contextView.addChild (scene as DisplayObject);
			scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.placeCard (cardCopy);
			
			dropContainer = collection.getDeckItemsStack();
			
			cardCopy.startDrag ();
			cardCopy.addEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
			contextView.stage.addEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave);
			
		}
		
		private function onCardModeMouseLeave (event:Event) :void {
			cardCopy.stopDrag();
			cardCopy.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave);
			TweenLite.to (cardCopy, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
		}
		
		private function onMouseUp (event:MouseEvent) :void {
			cardCopy.stopDrag();
			cardCopy.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave);
			
			var copyPosition:Point = new Point (cardCopy.x, cardCopy.y);
			copyPosition = cardCopy.parent.localToGlobal(copyPosition);

			if (copyPosition.x == position.x && copyPosition.y == position.y) {
				scene.endPlaceCard();
				dispatch (new CollectionEvent (CollectionEvent.ADD_DECK_ITEM));

			} else {
				TweenLite.to (cardCopy, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
			}
			
		}
		
		private function onBackComplete () :void {
			scene.endPlaceCard();
		}
		
		private function onCardModeMove (event:MouseEvent) :void {
			if (cardCopy.hitTestObject(dropContainer)) {
				cardCopy.stopDrag();
				cardCopy.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
				contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave);

				scene.endPlaceCard();
				
				if (!slot) {
					slot = new DeckItemSlot (cardCopy.getCardData());
				}
				slot.x = contextView.stage.mouseX - (slot.width / 2);
				slot.y = contextView.stage.mouseY - (slot.height / 2);
				scene.placeCard (slot);
				slot.addEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
				
				slot.startDrag();
				contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
				contextView.stage.addEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);
			}
		}
		
		private function onSlotModeMove (event:MouseEvent) :void {
			if (!slot.hitTestObject(dropContainer)) {
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
				contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave);
				slot.removeEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
				slot.stopDrag();
				scene.endPlaceCard();
				cardCopy.x = contextView.stage.mouseX - (cardCopy.width / 2);
				cardCopy.y = contextView.stage.mouseY - (cardCopy.height / 2);
				scene.placeCard (cardCopy);
				
				cardCopy.startDrag ();
				cardCopy.addEventListener (MouseEvent.MOUSE_UP, onMouseUp);
				contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
				contextView.stage.addEventListener(Event.MOUSE_LEAVE, onCardModeMouseLeave);

			}
		}
		
		private function onSlotModeMouseLeave (event:Event) :void {
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);
			slot.removeEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
			slot.stopDrag();
			scene.endPlaceCard();
			
			dispatch (new CollectionEvent (CollectionEvent.ADD_DECK_ITEM));
		}
		
		private function onSlotMouseUp (event:MouseEvent) :void {
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);
			slot.removeEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
			slot.stopDrag();
			scene.endPlaceCard();
			
			dispatch (new CollectionEvent (CollectionEvent.ADD_DECK_ITEM));
		}
	}

}