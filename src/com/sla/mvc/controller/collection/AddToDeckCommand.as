package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.view.card.CollectionCard;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.mvc.view.collection.deck.DeckItemsContainer;
	import flash.events.Event;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AddToDeckCommand extends StarlingCommand 
	{
		[Inject]
		public var event:CollectionEvent;
		
		[Inject]
		public var collection:Collection;
		
		private var card:CollectionCard;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('AddToDeckCommand::execute');
			card = event.data.card;
			
			var deckItemsContainer:DeckItemsContainer = collection.getDeckItemsStack() as DeckItemsContainer;
			
			
			if (card == null || card.isBlocked) {
				return;
			}
			
			
			var count:int = deckItemsContainer.slotsCount;
			if (count >= 30) {
				return;
			}
			
			count ++;
			deckItemsContainer.slotsCount = count;
			collection.setDecksItemsCount(count);
			
			
			deckItemsContainer.addSlot (card.getDeckSlotData());
			card.decrement();
		}
	}

}