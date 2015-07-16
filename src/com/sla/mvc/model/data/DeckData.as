package com.sla.mvc.model.data 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckData 
	{
		private var _title:String;
		private var _complicated:Boolean;
		private var _id:int;
		private var _count:int;
		private var _uid:int;
		private var _items:Vector.<CollectionCardData>;
		private var _hero:HeroData;
		
		public function DeckData() 
		{
			
		}
		
		public function set title (value:String) :void {
			this._title = value;
		}
		
		public function get title () :String {
			return _title;
		}
		
		public function set complicated (value:Boolean) :void {
			this._complicated = value;
		}
		
		public function get complicated () :Boolean {
			return _complicated;
		}
		
		public function set id (value:int) :void {
			this._id = value;
		}
		
		public function get id () :int {
			return _id;
		}
		
		public function set uid (value:int) :void {
			this._uid = value;
		}
		
		public function get uid () :int {
			return _uid;
		}
		
		public function set count (value:int) :void {
			this._count = value;
		}
		
		public function get count () :int {
			return _count;
		}
		
		public function set items (value:Vector.<CollectionCardData>) :void {
			_items = value;
		}
		
		public function get items ():Vector.<CollectionCardData>{
			return _items;
		}
		
		public function set hero (value:HeroData) :void {
			_hero = value;
		}
		
		public function get hero () :HeroData {
			return _hero;
		}		
	}

}