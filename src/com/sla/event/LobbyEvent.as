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