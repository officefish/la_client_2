package com.sla.mvc.controller.match.hand 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardsFromGraveyardCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var hand:PlayerHand;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		override public function execute():void 
		{
			MonsterDebugger.log('CardsFromGraveyardCommand::execute()');
			MonsterDebugger.log(event.data.cards);
			
			if (event.data.client) {
				hand.addCards(event.data.cards, true);
			} else {
				opponentHand.addCards(event.data.cards, true);
			}
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
	}

}