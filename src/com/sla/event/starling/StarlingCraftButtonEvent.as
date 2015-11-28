package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingCraftButtonEvent extends Event 
	{
		
		public static const CLICK:String = 'craftbtnclick';
		public static const CRAFT:String = 'craftBtnCraft';
		public static const DESTROY:String = 'craftBtnDestroy';
		
		public function StarlingCraftButtonEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}