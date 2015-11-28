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
		public static const REQUEST:String = 'request';
		public static const REQUEST_COMPLETE:String = 'requestComplete';
		public static const HEROES_INIT:String = 'heroesInit';
		public static const NEW_DECK_INIT:String = 'newDeckInit';
		public static const FULL_COLLECTION_INIT:String = 'fullCollectionInit';
		public static const CARD_CREATED:String = 'cardCreated';
		public static const CARD_DESTROYED:String = 'cardDestroyed';
		public static const ABILITIES_LIST_INIT:String = 'abilitiesListInit';
		public static const SETUP_ABILITIES:String = 'setupAbilities';
		public static const ABILITIES_CRAFT_LIST_INIT:String = 'abilitiesCraftListInit';
		public static const COMPLETE_CRAFT_ABILITY:String = 'completeCraftAbility';
		public static const COMPLETE_DUST_ABILITY:String = 'completeDustAbility';
		
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