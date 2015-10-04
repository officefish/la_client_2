package com.sla.event.starling 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StarlingCollectionEvent extends Event 
	{
		
		public static const EDIT:String = 'editDeckinCollection';
		public static const REMOVE:String = 'removeDeckinCollection';
		public static const PREVIEW:String = 'previewCollectionCard';
		
		
		public function StarlingCollectionEvent(type:String, bubbles:Boolean=false, data:Object=null) 
		{
			super(type, bubbles, data);
		}
		
	}

}