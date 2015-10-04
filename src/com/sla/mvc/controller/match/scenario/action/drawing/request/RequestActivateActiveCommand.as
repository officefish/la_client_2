package com.sla.mvc.controller.match.scenario.action.drawing.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestActivateActiveCommand extends StarlingCommand 
	{
		[Inject]
		public var service:MatchService; 
		
		[Inject]
		public var event:SceneEvent;
		
				
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestActivateActiveCommand::execute()');
			service.sendMessage ('activate_active', event.data);	
		}		
	}

}