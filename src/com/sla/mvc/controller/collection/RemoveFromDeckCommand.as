package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.view.card.CollectionCard;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.mvc.view.collection.deck.DeckItemsContainer;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RemoveFromDeckCommand extends StarlingCommand 
	{
		[Inject]
		public var event:CollectionEvent;
		
		[Inject]
		public var collection:Collection;
		
		private var card:CollectionCard; 
		
		override public function execute():void 
		{
			var slotId:int = event.data.slotId;
			
			var deckItemsContainer:DeckItemsContainer = collection.getDeckItemsStack() as DeckItemsContainer;
			
			var count:int = deckItemsContainer.slotsCount;
			count --;
			deckItemsContainer.slotsCount = count;
			collection.setDecksItemsCount(count);
			
			deckItemsContainer.removeSlot (slotId);
			
			card =  collection.getCardById (slotId);
			card.increment();
		}
		
	}

}