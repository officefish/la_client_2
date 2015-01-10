package com.la.mvc.view.collection 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ToolbarButtonEvent extends Event 
	{
		
		private var index:int;
		
		public static const CLICK:String = 'collectionBtnClick';
		
		public function ToolbarButtonEvent(type:String, index:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			this.index = index;
			super(type, bubbles, cancelable);
			
		}
		
		public function getIndex() :int {
			return index;
		}
		
		override public function clone():Event 
		{
			return new ToolbarButtonEvent(type, index, bubbles, cancelable);
		}
		
	}

}