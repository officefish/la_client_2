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
	public class OpponentPreflopClickCommand extends StarlingCommand 
	{
		[Inject]
		public var event:MatchServiceEvent;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		override public function execute():void 
		{
			opponentHand.click (event.data.index, event.data.select);
			MonsterDebugger.log('opponentPreflopClickCommand::execute()');
		}		
	}

}