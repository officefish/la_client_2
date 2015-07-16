package com.sla.event.starling {
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingIntroEvent extends Event  
	{
		
		public static const SELECT_COLLECTION:String = 'selectCollection';
		public static const SELECT_GAME:String = 'selectGame';
		public static const SELECT_STUDY:String = 'selectStudy';
		public static const SELECT_MARKET:String = 'selectMarket';
		public static const SELECT_QUEST:String = 'selectQuest';
		public static const SELECT_ARENA:String = 'selectArena';
		public static const COMPLETE:String = 'introComplete';
		public static const SELECT_HEROES:String = 'selectHeroes';
		
		public function StarlingIntroEvent(type:String, bubbles:Boolean=false) 
		{
			super(type, bubbles);
		}
		
		public function clone():Event {
			return new StarlingIntroEvent(type, bubbles)
		}
		
	}

}