package com.sla.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListEvent extends DataEvent
	{
		
		public static const REQUEST_DECKLIST:String = "request_decklist";
		public static const CLOSE:String = 'close_decklist';
		public static const STARTUP:String = 'startup_decklist';
		public static const READY:String = 'ready';
		
		public function DeckListEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new DeckListEvent (type, data, bubbles, cancelable);
		}
		
	}

}