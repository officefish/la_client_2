package com.sla.mvc.controller.match.hand.requests 
{
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.HandEvent;
	import com.sla.mvc.service.MatchService;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCursorOutCommand extends StarlingCommand 
	{
		[Inject]
		public var event:HandEvent; 
		
		[Inject]
		public var service:MatchService; 
		
		
		override public function execute():void 
		{
			//MonsterDebugger.log ('RequestCursorOutCommand::execute()');
			//MonsterDebugger.log (event.data);
			service.sendMessage('cursor_out', event.data);
		}
		
	}

}