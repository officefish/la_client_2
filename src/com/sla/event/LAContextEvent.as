package com.sla.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LAContextEvent extends Event 
	{
		
		public static const MODEL_INIT:String = 'laModelInit';
		public static const SERVICE_INIT:String = 'laServiceInit';
		public static const VIEW_INIT:String = 'laViewInit';
		public static const VALIDATE:String = 'validate';
				
		public function LAContextEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}