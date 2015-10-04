package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingCardEvent extends Event 
	{
		public static const PREFLOP_CLICK:String = 'preflopClick';
		
		public function StarlingCardEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
		
		
	}

}