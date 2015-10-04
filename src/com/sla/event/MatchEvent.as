package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MatchEvent extends DataEvent 
	{
		
		public static const STARTUP:String = 'startupMatch';
		public static const COLLECTION_INIT:String = 'collectionInit';
		public static const PREFLOP:String = 'preflop';
		public static const INIT_MATCH_MODEL:String = 'initMatchModel';
		public static const STARTUP_COMPLETE:String = 'startupComplete';
		public static const READY:String = 'matchReadyCommand';
		
		public function MatchEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new MatchEvent(type, data, bubbles, cancelable);
		}
		
	}

}