package com.sla.mvc.controller.lobby.dispather 
{
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.view.lobby.Lobby;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DispatcherConfirmCancelCommand extends StarlingCommand 
	{
		[Inject]
		public var event:LobbyServiceEvent;
		
		[Inject]
		public var lobby:Lobby; 
		
		override public function execute():void 
		{
			lobby.confirmCancelInvite(event.data.id);
		}		
	}

}