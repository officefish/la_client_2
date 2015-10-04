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
	public class RequestTargetForAptitudeInitCommand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var service:MatchService;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestForAptitudeInitCommand::execute');
			//MonsterDebugger.log (event.data.serviceData);
			service.sendMessage ('init_select', event.data);
			
		}
		
	}

}