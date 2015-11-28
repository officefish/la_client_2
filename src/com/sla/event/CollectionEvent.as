package com.sla.event 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionEvent extends DataEvent 
	{
		
		public static const STARTUP:String = 'startupCollection';
		public static const REQUEST_COLLECTION:String = 'requestCollection';
		public static const REMOVE_DECK:String = 'removeDeck';
		public static const EDIT_DECK:String = 'editDeck';
		public static const PREVIEW_CARD:String = 'previewCard';
		public static const ADD_TO_DECK:String = 'addToDeck';
		public static const REMOVE_FROM_DECK:String = 'removeFromDeck';
		public static const SAVE_DECK:String = 'saveDeck';
		public static const CLOSE:String = 'closeCollection';
		public static const NEW_DECK:String = 'newDeck';
		public static const HERO_SELECT:String = 'heroSelect';
		public static const CRAFT:String = 'collectionCraft';
		public static const CRAFT_READY:String = 'collectionCraftReady';
		public static const CRAFT_CARD:String = 'collectionCraftCard';
		public static const DUST_CARD:String = 'collectionDustCard';
		
		public function CollectionEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
			
		}
		
	}

}