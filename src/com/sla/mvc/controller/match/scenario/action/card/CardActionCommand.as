package com.sla.mvc.controller.match.scenario.action.card 
{
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardActionCommand extends StarlingCommand 
	{
		
		[Inject]
		public var playerHand:PlayerHand;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		public function getCard (index:int, attachment:int, client:Boolean) :Card {
			var _card:Card;
			if (client) {
				if (index >= 0) {
					if (attachment) {
						_card = playerHand.getCard(index);
					} else {
						_card = opponentHand.getCard(index);
					}
				} 
			} else {
				if (index >= 0) {
					if (!attachment) {
						_card = playerHand.getCard(index);
					} else {
						_card = opponentHand.getCard(index);
					}
				} 
			}
			return _card;
		}	
		
	}

}