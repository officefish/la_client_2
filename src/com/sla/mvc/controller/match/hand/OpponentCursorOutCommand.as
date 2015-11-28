package com.sla.mvc.controller.match.hand 
{
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.HandEvent;
	import com.sla.mvc.view.hand.OpponentHand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class OpponentCursorOutCommand extends StarlingCommand 
	{
		[Inject]
		public var event:HandEvent;
		
		[Inject] 
		public var opponentHand:OpponentHand;
		
		override public function execute():void 
		{
			//MonsterDebugger.log ('OpponentCursorOutCommand::execute()');
			opponentHand.out (event.data.index);
		}
		
	}

}