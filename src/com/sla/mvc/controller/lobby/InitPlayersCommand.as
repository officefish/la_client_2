package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.view.lobby.Lobby;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitPlayersCommand extends StarlingCommand 
	{
		[Inject]
		public var lobby:Lobby; 
		
		[Inject]
		public var event:LobbyServiceEvent;
		
		override public function execute():void 
		{
			MonsterDebugger.log("InitPlayersCommand::execute()");
			lobby.initPlayers(event.data.players);
		}		
	}

}