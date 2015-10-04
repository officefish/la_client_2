package com.sla.mvc.controller.match.preflop 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.MatchServiceEvent;
	import com.sla.mvc.view.hand.OpponentHand;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ChangeOpponentPreflopCommand extends StarlingCommand 
	{
		[Inject]
		public var opponentHand:OpponentHand;
		
		[Inject]
		public var event:MatchServiceEvent;
		
		override public function execute():void 
		{
			opponentHand.changeCards(event.data.opponent_preflop);
			MonsterDebugger.log('ChangeOpponentPreflopCommand::execute()');
		}	
	}

}