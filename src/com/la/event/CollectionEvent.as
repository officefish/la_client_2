package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionEvent extends Event 
	{
		
		public static const CLOSE:String = 'closeCollection';
		public static const NEW_DECK:String = 'newDeck';
		public static const SELECT_HERO:String = 'selectHeroInCollection';
		public static const ADD_DECK_ITEM:String = 'addDeckItem';
		public static const REMOVE_DECK_ITEM:String = 'removeDeckItem';
		public static const SAVE_DECK:String = 'saveDeck';
		public static const RESET_DECK:String = 'resetDeck';
		public static const REMOVE_DECK:String = 'removeDeck';
		public static const EDIT_DECK:String = 'editDeck';
		public static const CREATE_CARDS:String = 'createCards';
		public static const CRAFT_READY:String = 'craftReady';
		public static const CRAFT_CARD:String = 'craftCard';
		public static const DESTROY_CARD:String = 'destroyCard';
			
		private var data:Object;
		
		public function CollectionEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		public function getData () :Object {
			return data;
		}
		
		override public function clone():Event
		{
			return new CollectionEvent (type, data, bubbles, cancelable);
		}
		
	}

}