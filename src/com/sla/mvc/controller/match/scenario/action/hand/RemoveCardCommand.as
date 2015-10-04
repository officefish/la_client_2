package com.sla.mvc.controller.match.scenario.action.hand 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RemoveCardCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var playerHand:PlayerHand;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		override public function execute():void 
		{
			var card:Card;
			
			if (event.data.client) {
				card = playerHand.getCard(event.data.cardIndex);
				playerHand.removeCard(card);
			} else {
				if (event.data.enemy) {
					card = opponentHand.getCard(event.data.cardIndex);
					opponentHand.removeCard(card);
				}
			}
			if (card.getMirror().parent && card.getMirror().parent.contains(card.getMirror())) {
				card.getMirror().parent.removeChild(card.getMirror());
			}
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}
	}

}