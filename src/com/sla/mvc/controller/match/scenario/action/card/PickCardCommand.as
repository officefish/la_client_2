package com.sla.mvc.controller.match.scenario.action.card 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.event.starling.StarlingHandEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.hand.Hand;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PickCardCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var playerHand:PlayerHand;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		private var hand:Hand;
		
		override public function execute():void 
		{
			var data:Object = event.data;
			var cardData:CardData = data.card;
			var client:Boolean = data.client;
			var attachment:Boolean = data.attachment;
						
			if (client) {
				if (attachment) {
					hand = opponentHand;
				} else {
					hand = playerHand;
				}
			} else {
				if (attachment) {
					hand = playerHand;
				} else {
					hand = opponentHand;
				}
			}
			
			hand.addEventListener(StarlingHandEvent.PICK_COMPLETE, onPickComplete);
			hand.pickCard(cardData);
			
			
			MonsterDebugger.log ('PickCardCommand::execute()');
			
		}	
		
		private function onPickComplete (event:StarlingHandEvent) :void {
			hand.removeEventListener(StarlingHandEvent.PICK_COMPLETE, onPickComplete);
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}