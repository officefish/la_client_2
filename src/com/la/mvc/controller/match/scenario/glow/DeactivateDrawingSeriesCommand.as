package com.la.mvc.controller.match.scenario.glow 
{
	import com.la.event.ScenarioEvent;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.deck.PlayerDeck;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeactivateDrawingSeriesCommand extends Command 
	{
		[Inject (name='playerDeck')]
		public var deck:PlayerDeck; 
		
		
		override public function execute():void 
		{
			var cards:Array = deck.getCards();
			var card:Card; 
			
			for (var i:int = 0; i < cards.length; i ++) {
				card = cards[i] as Card;
				if (card.hasSeriesCondition) {
					card.defaultGlow(); 
				} 
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}		
	}

}