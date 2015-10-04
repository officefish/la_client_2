package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MatchServiceEvent extends DataEvent 
	{
		
		public static const CONNECTION_INIT:String = 'connectionInit';
		public static const PREFLOP_INIT:String = 'servicePreflopInit';
		public static const CHANGE_PREFLOP:String = 'changePreflop';
		public static const END_PREFLOP:String = 'endPreflop';
		public static const OPPONENT_PREFLOP_CLICK:String = 'opponentPreflopClick';
		public static const CHANGE_OPPONENT_PREFLOP:String = 'changeOpponentPreflop';
		public static const READY:String = 'ready';
		public static const OPPONENT_STEP:String = 'opponentStep';
		public static const PLAYER_STEP:String = 'player_step';
		public static const SCENARIO:String = 'scenario';
		public static const END_STEP_TIMER:String = 'endStepTimer';
		public static const END_MATCH:String = 'end_match_in_service';
		public static const REPLACE_DECK_ITEMS:String = 'replace_deck_items';
		
		public function MatchServiceEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new MatchServiceEvent(type, data, bubbles, cancelable);
		}
		
	}

}