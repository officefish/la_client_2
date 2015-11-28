package com.sla.mvc.controller.lobby.dispather 
{
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.view.lobby.Lobby;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DispatcherConfirmInviteCommand extends StarlingCommand 
	{
		[Inject]
		public var event:LobbyServiceEvent;
		
		[Inject]
		public var lobby:Lobby; 
		
		override public function execute():void 
		{
			var id:int = event.data.id;
			var mode:int = event.data.mode; 
			var uid:int = event.data.uid;
			var level:int = event.data.level; 
			var nickname:String = event.data.nickname;
			
			lobby.confirmInvite({id:id, mode:mode, uid:uid, level:level, nickname:nickname});
		}	
	}

}