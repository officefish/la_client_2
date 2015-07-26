package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.LobbyEvent;
	import com.sla.event.starling.StarlingLobbyEvent;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LobbyMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingLobbyEvent.INVITE, onInvite);
			addViewListener(StarlingLobbyEvent.CANCEL, onCancel);
			addViewListener(StarlingLobbyEvent.ACCEPT, onAccept);
			addViewListener(StarlingLobbyEvent.CLOSE, onClose);
		}
		
		private function onClose (event:StarlingLobbyEvent) :void {
			dispatch(new LobbyEvent(LobbyEvent.FORCE_CLOSE));
		}
		
		private function onInvite (event:StarlingLobbyEvent) :void {
			dispatch(new LobbyEvent(LobbyEvent.INVITE, event.data));
		}
		
		private function onCancel (event:StarlingLobbyEvent) :void {
			dispatch(new LobbyEvent(LobbyEvent.CANCEL, event.data));
		}
		
		private function onAccept (event:StarlingLobbyEvent) :void {
			dispatch(new LobbyEvent(LobbyEvent.ACCEPT, event.data));
		}
	}

}