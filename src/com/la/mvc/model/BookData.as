package com.la.mvc.model 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BookData 
	{
		private var _items:Array;
		private var _title:String;
		private var _description:String;
		
		public function BookData() 
		{
			_items = []
		}
		
		public function setTitle (value:String) :void {
			_title = value;
		}
		
		public function getTitle () :String {
			return _title;
		}
		
		public function setDescription (value:String) :void {
			_description = value;
		}
		
		public function getDescription () :String {
			return _description;
		}
		
		public function addItem (item:CollectionCardData):void {
			_items.push(item)
		}
		
		public function getItems () :Array {
			return _items.concat();
		}
		
	}

}