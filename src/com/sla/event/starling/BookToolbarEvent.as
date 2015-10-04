package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BookToolbarEvent extends Event 
	{
		public static const CLICK:String = 'itemClick';
		
		public function BookToolbarEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}