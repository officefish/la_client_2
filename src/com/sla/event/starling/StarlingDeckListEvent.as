package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingDeckListEvent extends Event 
	{
		
		public static const CLOSE:String = 'close';
		public static const EDIT_DECK:String = 'edit_deck';
		public static const READY:String = 'ready';
		public static const REMOVE_SLOT:String = 'removeSlot';
		
		public function StarlingDeckListEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}