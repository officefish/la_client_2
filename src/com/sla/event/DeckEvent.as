package com.sla.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckEvent extends DataEvent
	{
		
		public static const REQUEST_DECKLIST:String = "request_decklist";
		
		public function DeckEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new DeckEvent (type, data, bubbles, cancelable);
		}
		
	}

}