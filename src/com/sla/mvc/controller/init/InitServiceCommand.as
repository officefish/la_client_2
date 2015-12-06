package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.LobbyService;
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
		
		[Inject]
		public var lobbyService:LobbyService;
		
		[Inject]
		public var rootModel:RootModel;
		
		override public function execute():void 
		{
			apiService.host = rootModel.hostname;
			apiService.port = 8000;
			apiService.userId = 1;
			
			lobbyService.init(apiService.host, 8003, 'lobby');
			
			MonsterDebugger.log ("InitServiceCommand::execute()");
			dispatch(new LAContextEvent(LAContextEvent.SERVICE_INIT));
		}	
	}

}