package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListItemEvent extends Event 
	{
		
		public static const EDIT_DECK:String = 'editDeck';
		public static const SELECT:String = 'select';
		
		public function DeckListItemEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}