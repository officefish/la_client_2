package com.sla.mvc.controller.match.scenario.action.drawing.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCancelSelectForAptCommand extends StarlingCommand 
	{
		[Inject]
		public var service:MatchService; 
		
				
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestCancelSelectForAptitudeCommand::execute()');
			service.sendMessage ('cancel_select', {});	
		}
			
	}

}