package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ApiServiceEvent extends Event 
	{
		
		private var _data:Object;
		
		public static const COLLECTION_INIT:String = 'collectionInit';
		public static const HEROES_INIT:String = 'heroesInit';
		public static const NEW_DECK_INIT:String = 'newDeckInit';
		public static const EDIT_DECK_INIT:String = 'editDeckInit';
		public static const INTRO_DECK_LIST_INIT:String = 'introDeckListInit';
		public static const INTRO_DECK_SELECT:String = 'introDeckSelect';
		public static const FULL_COLLECTION_INIT:String = 'fullCollectionInit';
		public static const CARD_CREATED:String = 'cardCreated';
		public static const CARD_DESTROYED:String = 'cardDestroyed';
		
		public static const REQUEST:String = 'request';
		public static const REQUEST_COMPLETE:String = 'request_complete';
		
		public static const ACHIEVES_LIST_INIT:String = 'achievesListInit';
		public static const SETUP_SERVICE_COMPLETE:String = 'setupServiceComplete';
		public static const ACHIEVES_CRAFT_LIST_INIT:String = 'achievesCraftListInit';
		public static const ACHIEVE_CRAFT_COMPLETE:String = 'achieveCraftComplete';
		public static const ACHIEVE_DESTROY_COMPLETE:String = 'achieveDestroyComplete';
		
		public function ApiServiceEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			this._data = data;
			super(type, bubbles, cancelable)
		}

		public function getData () :Object {
			return _data;
		}

		override public function clone():Event {
			return new ApiServiceEvent(type, _data, bubbles, cancelable)
		}
		
	}

}