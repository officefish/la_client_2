package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldEvent extends DataEvent 
	{
		
		public static const FIND_MINION_POSITION:String = 'findMinionPosition';
		public static const STOP_FIND_MINION_POSITION:String = 'stopFindMinionPosition';
		public static const SHOW_MIRROR:String = 'showMirror';
		public static const HIDE_MIRROR:String = 'hideMirror';
				
		public function FieldEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new FieldEvent(type, data, bubbles, cancelable);
		}
		
	}

}