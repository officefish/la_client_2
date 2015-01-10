package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ConsoleEvent extends Event 
	{
		
		public var msg:String;
		public var initiator:Object;
		
		public static const DEBUG:String = 'debug__Console';
		
		public function ConsoleEvent(type:String, msg:String, initiator:Object, bubbles:Boolean = false, cancelable:Boolean = false) 
		{
			super(type, bubbles, cancelable);
			this.msg = msg;
			this.initiator = initiator;
		}
		
		override public function clone():Event 
		{
			return new ConsoleEvent (type, msg, initiator, bubbles, cancelable);
		}
		
	}

}