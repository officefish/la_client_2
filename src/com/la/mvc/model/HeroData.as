package com.la.mvc.model 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroData 
	{
		
		private var _title:String;
		private var _vocation:String;
		private var _description:String;
        private var _uid:int;
        private var _id:int;
        private var _level:int;
		
		public function set title (value:String) :void {
			this._title = value;
		}
		public function get title () :String {
			return _title;
		}
		public function set vocation (value:String) :void {
			this._vocation = value;
		}
		public function get vocation () :String {
			return _vocation;
		}
		public function set description (value:String) :void {
			this._description = value;
		}
		public function get description () :String {
			return _description;
		}
		public function set uid (value:int) :void {
			this._uid = value;
		}
		public function get uid () :int {
			return _uid;
		}
		public function set id (value:int) :void {
			this._id = value;
		}
		public function get id () :int {
			return _id;
		}
		public function set level (value:int) :void {
			this._level = value;
		}
		public function get level() :int {
			return _level;
		}
		
	}

}