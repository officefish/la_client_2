package com.sla.mvc.controller.match.hand 
{
	import com.sla.mvc.view.hand.OpponentHand;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.HandEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class OpponentCursorOverCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:HandEvent;
		
		[Inject] 
		public var opponentHand:OpponentHand;
		
		override public function execute():void 
		{
			//MonsterDebugger.log ('OpponentCursorOverCommand::execute()');
			opponentHand.over (event.data.index);
		}
		
	}

}