package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingFieldEvent extends Event 
	{
		
		public static const END_STEP:String = 'fieldEndStep';
		public static const WIDGET_ACTIVATE:String = 'widgetActivate';
		
		public function StarlingFieldEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}