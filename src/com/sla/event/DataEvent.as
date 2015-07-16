package com.sla.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DataEvent extends Event 
	{
		
		private var _data:Object;
		
		public function DataEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			this._data = data;
			super(type, bubbles, cancelable);
		}
		
		public function get data () :Object {
			return _data;
		}
		
		override public function clone():Event 
		{
			return new DataEvent (type, data, bubbles, cancelable);
		}
		
	}

}