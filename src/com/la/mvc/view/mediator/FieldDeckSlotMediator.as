package com.la.mvc.view.mediator 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.view.field.deck.FieldDeckSlot;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldDeckSlotMediator extends Mediator 
	{
		[Inject]
		public var slot:FieldDeckSlot;
		
		override public function onRegister():void 
		{
			eventMap.mapListener(slot, MouseEvent.MOUSE_OVER, onMouseOver);
			eventMap.mapListener(slot, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(slot, MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			Mouse.cursor = MouseCursor.HAND;  
			dispatch(new DeckEvent(DeckEvent.PREVIEW_FIELD_DECK_SLOT, { slot:slot } ));
			
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			if (slot.getMirror().parent) {
				Mouse.cursor = MouseCursor.AUTO;  
				slot.getMirror().parent.removeChild(slot.getMirror());
			}
		}
		
		private function onMouseDown (event:MouseEvent) :void {
			if (slot.getMirror().parent) {
				slot.getMirror().parent.removeChild(slot.getMirror());
			}
			dispatch(new DeckEvent(DeckEvent.FIELD_DECK_SLOT_DOWN, { slot:slot } ));
		}
		
	}

}