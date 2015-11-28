package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.event.starling.StarlingCollectionEvent;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckSlotMediator extends StarlingMediator 
	{
		
		override public function onRegister():void 
		{
			addViewListener(StarlingCollectionEvent.EDIT, onEditDeck);
			addViewListener(StarlingCollectionEvent.REMOVE, onRemoveDeck);
		}
		
		private function onEditDeck(event:StarlingCollectionEvent) :void {
			dispatch (new CollectionEvent(CollectionEvent.EDIT_DECK, {deckId:event.data.deckData.id}));
		}
		
		private function onRemoveDeck(event:StarlingCollectionEvent) :void {
			dispatch (new CollectionEvent(CollectionEvent.REMOVE_DECK, {deckId:event.data.deckData.id}));
		}
		
	}

}