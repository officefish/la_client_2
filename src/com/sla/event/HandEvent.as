package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HandEvent extends DataEvent 
	{
		public static const START_DRAG:String = 'startDragCard';
		public static const PLAY_CARD:String = 'playCard';
		public static const SELECT_TARGET_FOR_SPELL:String = 'selectTargetForSpell';
		
		public function HandEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new HandEvent(type, data, bubbles, cancelable);
		}
		
		
	}

}