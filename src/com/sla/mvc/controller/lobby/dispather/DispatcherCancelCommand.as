package com.sla.mvc.controller.lobby.dispather 
{
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.view.lobby.Lobby;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DispatcherCancelCommand extends StarlingCommand 
	{
		[Inject]
		public var event:LobbyServiceEvent;
		
		[Inject]
		public var lobby:Lobby; 
		
		override public function execute():void 
		{
			lobby.cancelInvite(event.data.id);
		}		
	}

}