package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveEvent extends Event 
	{
		public static const SAVE:String = 'saveAchieveSetup';
		public static const CLOSE:String = 'close';
		public static const CREATE:String = 'createAchieves';
		public static const CRAFT:String = 'craftAchieve';
		public static const DESTROY:String = 'destroyAchieve';
		public static const CLOSE_CRAFT:String = 'closeCraft';
		public static const READY_CRAFT:String = 'readyCraft';
		
		private var data:Object;
		public function AchieveEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.data = data;
		} 
		
		public function getData() :Object {
			return data;
		}
		
		public override function clone():Event 
		{ 
			return new AchieveEvent(type, data, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("AchieveEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}