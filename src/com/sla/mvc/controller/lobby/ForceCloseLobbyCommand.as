package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.LobbyEvent;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import com.sla.mvc.view.lobby.Lobby;
	import com.sla.mvc.service.LobbyService;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ForceCloseLobbyCommand extends StarlingCommand 
	{
		[Inject]
		public var lobby:Lobby;

		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var lobbyService:LobbyService;
		
		override public function execute():void 
		{
			MonsterDebugger.log('ForseCloseLobbyCommand;;execute()') 
			lobbyService.close();
			lobby.clear();

			if (contextView.contains(lobby)) {
				contextView.removeChild(lobby);
			}
					
			stateModel.state = GameState.INTRO;
			dispatch(new LobbyEvent(LobbyEvent.CLOSE)); 
		}		
	}

}