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
		
		public function CollectionEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
			
		}
		
	}

}