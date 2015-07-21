package com.sla.mvc.controller.lobby 
{
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.view.lobby.Lobby;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LeaveLobbyCommand extends StarlingCommand 
	{
		[Inject]
		public var lobby:Lobby;
		
		[Inject]
		public var event:LobbyServiceEvent;
		
		override public function execute():void 
		{
			lobby.removeUser(event.data.id);
		}	
	}

}