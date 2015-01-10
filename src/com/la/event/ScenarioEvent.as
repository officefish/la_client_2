package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioEvent extends Event 
	{
		
		public static const ACTION:String = 'scenarioAction';
				
		public function ScenarioEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new ScenarioEvent (type, bubbles, cancelable);
		}
		
	}

}