package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.service.ApiService;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitServiceCommand extends StarlingCommand 
	{
		[Inject]
		public var apiService:ApiService;
		
		override public function execute():void 
		{
			apiService.host = '127.0.0.1';
			apiService.port = 8000;
			apiService.userId = 1;
			
			MonsterDebugger.log ("InitServiceCommand::execute()");
			dispatch(new LAContextEvent(LAContextEvent.SERVICE_INIT));
		}	
	}

}