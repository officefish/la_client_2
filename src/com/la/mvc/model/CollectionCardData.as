package com.la.mvc.model 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionCardData extends CardData 
	{
		
		private var _id:int;
		private var _golden:Boolean;
		private var _count:int;
		
		public function CollectionCardData(attack:int, health:int, price:int, eptitudes:Array=null) 
		{
			super(attack, health, price, eptitudes);
		}
		
		public function setId (value:int) :void {
			this._id = value;
		}
		
		public function getId () :int {
			return _id;
		}
		
		public function setCount (value:int) :void {
			this._count = value;
		}
		
		public function getCount () :int {
			return _count;
		}
		
		public function setGolden (value:Boolean) :void {
			_golden  = value;
		}
		
		public function isGolden () :Boolean {
			return _golden;
		}
		
		
		
		
	}

}