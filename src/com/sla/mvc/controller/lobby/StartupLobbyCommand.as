package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.LobbyEvent;
	import com.sla.mvc.view.lobby.Lobby;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupLobbyCommand extends StarlingCommand 
	{
		[Inject]
		public var lobby:Lobby;
		
		override public function execute():void 
		{
			MonsterDebugger.log("StartupLobbyCommand::execute()");
			lobby.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(lobby);
			
			dispatch(new LobbyEvent(LobbyEvent.CONNECT));
		}		
	}

}