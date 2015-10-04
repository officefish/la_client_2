package com.sla.mvc.controller.match.startup 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupMatchServiceCommand extends StarlingCommand 
	{
		[Inject]
		public var matchModel:MatchModel;

		[Inject]
		public var rootModel:RootModel; 

		[Inject]
		public var service:MatchService; 

		override public function execute():void {
			MonsterDebugger.log('StartupMatchServiceCommand::execute()');
			service.init('127.0.0.1', 8003, matchModel.matchId);
			service.setUserData({'id':rootModel.lobbyId})
			service.connect();
		}
	}

}