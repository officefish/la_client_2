package com.la.mvc.controller.match.deck 
{
	import com.la.event.ScenarioEvent;
	import com.la.mvc.model.CardType;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class GlowCardsCommand extends Command 
	{
		[Inject (name='playerDeck')]
		public var deck:PlayerDeck;
		
		[Inject (name='deckModel')]
		public var model:DeckModel;
		
		[Inject (name='field')]
		public var field:IField;
		
		override public function execute():void 
		{
			if (model.block) {
				dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
				return;
			}
			
			var cards:Array = deck.getCards();
			var card:Card;
			var numUnits:int = field.getUnitsNumChildren ();
			var opponentNumUnits:int = field.getUnitsNumChildren (false);
			
			for (var i:int = 0; i < cards.length; i ++) {
				
				card = cards[i] as Card;
				card.stopGlow();
				card.filters = [];
				
				if (card.getPrice() > model.price) {
					continue;
				}
				if (card.getType() == CardType.UNIT && numUnits == 7) {
					continue;
				}
				if (card.hasSeveralTargetsEptitude && opponentNumUnits < 2) {
					continue;
				}
				card.glow(); 
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
	}

}