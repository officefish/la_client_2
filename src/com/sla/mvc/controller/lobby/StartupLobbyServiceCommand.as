package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.LobbyService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupLobbyServiceCommand extends StarlingCommand 
	{
		[Inject]
		public var service:LobbyService;
		
		[Inject]
		public var rootModel:RootModel;
		
		[Inject]
		public var heroModel:HeroModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('StartupLobbyServiceCommand::execute()');
			
			rootModel.lobbyId = Math.round(Math.random() * 50000);
			service.setUserData({'id':rootModel.lobbyId, 'hero_id':heroModel.heroId, 'deck_id':heroModel.deckId, 'hero_uid':heroModel.type, 'level':heroModel.level});
			service.connect();			
		}		
	}

}