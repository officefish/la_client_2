package com.sla.mvc.view 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingRobotlegsSprite extends Sprite 
	{
		
		protected var robotlegsDispatcher:IEventDispatcher;
		
		public function StarlingRobotlegsSprite() 
		{
			robotlegsDispatcher = new EventDispatcher ();
			super();
		}
		
		public function dispatchToMediator (event:Event) : void {
			robotlegsDispatcher.dispatchEvent (event);
		}
		
		public function get mediatorDispatcher () :IEventDispatcher {
			return robotlegsDispatcher;
		}
		
	}

}