package com.la.mvc.controller.collection 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.CollectionEvent;
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
	public class DragSlotDeckCommand extends Command 
	{
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		private var slotCopy:DeckItemSlot;
		private var position:Point;
		
		[Inject (name='scene')]
		public var scene:IScene;  
		
		private var dropContainer:Sprite; 
		private var card:CollectionCard;
		
		[Inject (name='collection')]
		public var collection:ICollection;  
		
			
		override public function execute():void 
		{
			var slot:DeckItemSlot  = model.deckSlot;
			slotCopy = new DeckItemSlot (slot.getCardData());
			
			position = new Point(slot.x, slot.y); 
			position = slot.parent.localToGlobal(position);
			
			slotCopy.x = position.x;
			slotCopy.y = position.y; 
			
			contextView.addChild (scene as DisplayObject);
			scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.placeCard (slotCopy);
			
			dropContainer = collection.getDeckItemsStack();
			
			slotCopy.startDrag ();
			slotCopy.addEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
			contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
			contextView.stage.addEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);

		}	
		
		private function onSlotModeMove (event:MouseEvent) :void {
			if (!slotCopy.hitTestObject(dropContainer)) {
				slotCopy.stopDrag();
				slotCopy.removeEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
				contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
				scene.endPlaceCard();
				
				if (!card) {
					card = new CollectionCard (slotCopy.getCardData(), false);
				}
				card.x = contextView.stage.mouseX - (card.width / 2);
				card.y = contextView.stage.mouseY - (card.height / 2);
				scene.placeCard (card);
				card.addEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
				
				card.startDrag();
				
				contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
				contextView.stage.addEventListener (Event.MOUSE_LEAVE, onCardModeMouseLeave);

			}
		}
		
		private function onCardModeMove (event:MouseEvent) :void {
			if (card.hitTestObject(dropContainer)) {
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
				contextView.stage.removeEventListener (Event.MOUSE_LEAVE, onCardModeMouseLeave);
				card.removeEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
				card.stopDrag();
				scene.endPlaceCard();
				slotCopy.x = contextView.stage.mouseX - (slotCopy.width / 2);
				slotCopy.y = contextView.stage.mouseY - (slotCopy.height / 2);
				scene.placeCard (slotCopy);
				
				slotCopy.startDrag ();
				slotCopy.addEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
				contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
				contextView.stage.addEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);

			}
		}
		
		private function onSlotMouseUp (event:MouseEvent) :void {
			slotCopy.stopDrag();
			slotCopy.removeEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);

			
			var copyPosition = new Point(slotCopy.x, slotCopy.y); 
			copyPosition = slotCopy.parent.localToGlobal(copyPosition);
			
			if (copyPosition.x == position.x && copyPosition.y == position.y) {
				scene.endPlaceCard();
				dispatch (new CollectionEvent (CollectionEvent.REMOVE_DECK_ITEM, {'cardCopy':card}));
			} else {
				TweenLite.to (slotCopy, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
			}
		} 
		
		private function onSlotModeMouseLeave (event:Event) :void {
			slotCopy.stopDrag();
			slotCopy.removeEventListener (MouseEvent.MOUSE_UP, onSlotMouseUp);
			contextView.stage.removeEventListener(Event.MOUSE_LEAVE, onSlotModeMouseLeave);
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onSlotModeMove);
			TweenLite.to (slotCopy, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onBackComplete } );
		} 
		
		private function onBackComplete () :void {
			scene.endPlaceCard();
		}
		
		private function onCardMouseUp (event:MouseEvent) :void {
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
			contextView.stage.removeEventListener (Event.MOUSE_LEAVE, onCardModeMouseLeave);

			card.removeEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
			card.stopDrag();
			scene.endPlaceCard();
			
			dispatch (new CollectionEvent (CollectionEvent.REMOVE_DECK_ITEM, {'cardCopy':card}));
		} 
		
		private function onCardModeMouseLeave (event:Event) :void {
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onCardModeMove);
			contextView.stage.removeEventListener (Event.MOUSE_LEAVE, onCardModeMouseLeave);

			card.removeEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
			card.stopDrag();
			scene.endPlaceCard();
			
			dispatch (new CollectionEvent (CollectionEvent.REMOVE_DECK_ITEM, {'cardCopy':card}));
		}
	}
	
	

}