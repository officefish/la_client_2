package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroListItemEvent extends Event 
	{
		
		public static const SELECT:String = 'heroListItemEvent';
		
		public function HeroListItemEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
			
		}
		
	}

}