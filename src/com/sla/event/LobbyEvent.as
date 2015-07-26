package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LobbyEvent extends DataEvent 
	{
		public static const STARTUP:String = 'startupLobby';
		public static const CONNECT:String = 'connect';
		public static const INVITE:String = 'invite';
		public static const ACCEPT:String = 'acceptInvitation';
		public static const REJECT:String = 'rejectInvitation';
		public static const CANCEL:String = 'cancelInvitation';
		public static const CLOSE:String = 'close';
		public static const FORCE_CLOSE:String = 'forceClose';
		
		public function LobbyEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new LobbyEvent(type, data, bubbles, cancelable);
		}
		
	}

}