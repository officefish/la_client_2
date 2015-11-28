package com.sla.mvc.controller.match.hand.requests {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.HandEvent;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCursorOverCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:HandEvent; 
		
		[Inject]
		public var service:MatchService; 
		
		override public function execute():void 
		{
			//MonsterDebugger.log ('RequestCursorOverCommand::execute()');
			//MonsterDebugger.log (event.data);
			service.sendMessage('cursor_over', event.data);
		}
		
	}

}