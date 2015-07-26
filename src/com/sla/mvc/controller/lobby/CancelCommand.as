package com.sla.mvc.controller.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.service.LobbyService;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.event.LobbyEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CancelCommand extends StarlingCommand 
	{
		[Inject]
		public var service:LobbyService;

		[Inject]
		public var event:LobbyEvent; 

		override public function execute () :void {
			MonsterDebugger.log('CancelCommand::execute()');
			service.sendMessage('cancel_invite', {'unit':event.data.id})
		}		
	}

}