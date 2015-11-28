package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.event.starling.StarlingCollectionEvent;
	import com.sla.event.starling.StarlingDeckListEvent;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingDeckListEvent.REMOVE_SLOT, onRemoveSlot); 
			addViewListener(StarlingCollectionEvent.SAVE, onSaveDeck);
			addViewListener(StarlingCollectionEvent.CLOSE, onClose);
			addViewListener(StarlingCollectionEvent.NEW_DECK, onNewDeck);
			addViewListener(StarlingCollectionEvent.HERO_DELECT, onHeroSelect);
			addViewListener(StarlingCollectionEvent.CRAFT, onCraft);
			addViewListener(StarlingCollectionEvent.CRAFT_READY, onCraftReady);
		}
		
		private function onCraftReady (event:StarlingCollectionEvent) :void {
			dispatch (new CollectionEvent(CollectionEvent.CRAFT_READY));
		}
		
		private function onCraft (event:StarlingCollectionEvent) :void {
			dispatch (new CollectionEvent(CollectionEvent.CRAFT));
		}
		
		private function onHeroSelect (event:StarlingCollectionEvent) :void {
			dispatch(new CollectionEvent(CollectionEvent.HERO_SELECT, event.data ));

		}
		
		private function onRemoveSlot (event:StarlingDeckListEvent) :void {
			dispatch(new CollectionEvent(CollectionEvent.REMOVE_FROM_DECK, { slotId:event.data.slotId } ));
		}
		
		private function onSaveDeck (event:StarlingCollectionEvent) :void {
			dispatch (new CollectionEvent(CollectionEvent.SAVE_DECK, event.data))
		}
		private function onClose (event:StarlingCollectionEvent) :void {
			dispatch (new CollectionEvent(CollectionEvent.CLOSE));
		}
		private function onNewDeck (event:StarlingCollectionEvent) :void {
			dispatch (new CollectionEvent(CollectionEvent.NEW_DECK));
		}
		
	}

}