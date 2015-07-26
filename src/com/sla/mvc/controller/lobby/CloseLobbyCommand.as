package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.service.LobbyService;
	import com.sla.mvc.view.lobby.Lobby;
	import com.sla.event.LobbyEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CloseLobbyCommand extends StarlingCommand 
	{
	    [Inject]
		public var event:LobbyServiceEvent;

		[Inject]
		public var lobbyService:LobbyService;

		[Inject]
		public var lobby:Lobby;

		[Inject]
		public var matchModel:MatchModel; 
		
		[Inject]
		public var stateModel:StateModel;

   		override public function execute():void 
		{
			MonsterDebugger.log('CloseLobbyCommand;;execute()')
			lobbyService.close();
			lobby.clear();

			if (contextView.contains(lobby)) {
				contextView.removeChild(lobby);
			}
			matchModel.matchId = event.data.match_id;
			
			stateModel.state = GameState.MATCH;
			dispatch(new LobbyEvent(LobbyEvent.CLOSE));
		}
		
	}

}