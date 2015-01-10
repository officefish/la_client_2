package com.la.mvc.view.mediator 
{
	import com.la.event.CollectionEvent;
	import com.la.mvc.view.collection.DeckSlot;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckSlotMediator extends Mediator 
	{
		[Inject]
		public var slot:DeckSlot;
		
		override public function onRegister():void {
			eventMap.mapListener(slot, CollectionEvent.REMOVE_DECK, listener); 
			eventMap.mapListener(slot, CollectionEvent.EDIT_DECK, listener);
		}
		
		private function listener (event:CollectionEvent) :void {
			dispatch (event);
		}
	}

}