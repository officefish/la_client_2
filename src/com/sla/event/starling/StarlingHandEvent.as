package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingHandEvent extends Event 
	{
		
		public static const PICK_COMPLETE:String = 'pickComplete';
		
		public function StarlingHandEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}