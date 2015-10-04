package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ApiServiceEvent extends DataEvent 
	{
		
		public static const DECKLIST_INIT:String = 'decklistInit';
		public static const INTRO_DECKLIST_INIT:String = 'introDecklistInit';
		public static const DECK_READY_TO_LOBBY:String = 'deckReadyToLobby';
		public static const COLLECTION_INIT:String = 'collectionInit';
		public static const EDIT_DECK_INIT:String = 'deckInit';
		
		public function ApiServiceEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new ApiServiceEvent(type, data, bubbles, cancelable);
		}
		
	}

}