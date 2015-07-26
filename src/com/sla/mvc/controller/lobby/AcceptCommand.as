package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.LobbyEvent;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.LobbyService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AcceptCommand extends StarlingCommand 
	{
		[Inject]
		public var service:LobbyService;

		[Inject]
		public var event:LobbyEvent;


		[Inject]
		public var model:RootModel;


		override public function execute () :void {
			MonsterDebugger.log('AcceptCommand:execute()')
			service.sendMessage('accept_invite', 
			{ 
				'player1': event.data.id, 
				'player2': model.lobbyId, 
				'mode':event.data.mode
			})
		}		
	}

}