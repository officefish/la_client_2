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
		
		public static const CURSOR_OVER:String = 'cursorOver';
		public static const CURSOR_OUT:String = 'cursorOut';
		public static const OPPONENT_CURSOR_OVER:String = 'opponentCursorOver';
		public static const OPPONET_CURSOR_OUT:String = 'opponentCursorOut';
		
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