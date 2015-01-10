package com.la.mvc.view.mediator 
{
	import com.la.event.CardEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.view.collection.DeckItemsContainer;
	import com.la.mvc.view.collection.DeckItemSlot;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckItemSlotMediator extends Mediator 
	{
		[Inject]
		public var slot:DeckItemSlot;
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		
		override public function onRegister():void 
		{
			eventMap.mapListener(slot, MouseEvent.MOUSE_DOWN, onMouseDown);
			eventMap.mapListener(slot, MouseEvent.MOUSE_OVER, onMouseOver);
			eventMap.mapListener(slot, MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			Mouse.cursor = MouseCursor.HAND; 
		}
		private function onMouseOut (event:MouseEvent) :void {
			Mouse.cursor = MouseCursor.AUTO; 
		}
		
		private function onMouseDown (event:MouseEvent) :void {
			if (!event.target.parent.parent) return;
			if (event.target.parent.parent is DeckItemsContainer) {
				model.deckSlot = slot;
				dispatch (new CardEvent (CardEvent.DRAG_SLOT, {'slot':slot}))
			}

		}
	}

}