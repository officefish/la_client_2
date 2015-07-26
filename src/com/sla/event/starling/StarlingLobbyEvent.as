package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingLobbyEvent extends Event 
	{
		
		public static const INVITE:String = 'invite';
		public static const ACCEPT:String = 'accept';
		public static const CANCEL:String = 'cancel';
		public static const CLOSE:String = 'close';
		
		public function StarlingLobbyEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}