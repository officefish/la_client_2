package com.sla.mvc.controller.lobby 
{
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.view.lobby.Lobby;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class JoinToLobbyCommand extends StarlingCommand 
	{
		[Inject]
		public var lobby:Lobby;

		[Inject] 
		public var model:RootModel;
		
		[Inject]
		public var event:LobbyServiceEvent;
		
		override public function execute():void 
		{
			
			var player:Boolean = model.lobbyId == event.data.id ? true : false; 	
			var user:Object = { 'id':event.data.id, 'uid':event.data.uid, 'level':event.data.level, player:player };
			lobby.addUser(user);
		}		
	}

}