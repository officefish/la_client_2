package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingSceneEvent extends Event 
	{
		public static const WELCOME_COMPLETE:String = 'welcomeSceneEvent';
		public static const CHANGE_PREFLOP:String = 'changePreflop';
		public static const PREFLOP_INIT:String = 'preflopInit';
		
		public function StarlingSceneEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}