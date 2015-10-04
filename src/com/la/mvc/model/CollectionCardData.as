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
		
		// craft variables;
		private var _buyCost:int;
		private var _saleCost:int;
		private var _rarity:int; 
		private var _accessSimple:int;
		private var _maxSimple:int;
		private var _accessGolden:int; 
		private var _maxGolden:int;
		private var _simpleCount:int;
		private var _goldenCount:int;
		private var _craftAvailable:Boolean;
		
		
		public function CollectionCardData(attack:int, health:int, price:int, eptitudes:Array=null) 
		{
			super(attack, health, price, eptitudes);
		}
		
		public function set id (value:int) :void {
			this._id = value;
		}
		
		public function get id () :int {
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
		
		// craft variables
		
		public function setBuyCost (value:int) :void {
			this._buyCost = value;
		}
		
		public function getBuyCost () :int {
			return _buyCost;
		}
		
		public function setSaleCost (value:int) :void {
			this._saleCost = value;
		}
		
		public function getSaleCost () :int {
			return _saleCost;
		}
		
		public function setRarity (value:int) :void {
			this._rarity = value; 
		}
		
		public function setAccessSimple (value:int) :void {
			this._accessSimple = value;
		}
		
		public function setMaxSimple (value:int) :void {
			this._maxSimple = value;
		}
		
		public function getMaxSimple () :int {
			return _maxSimple;
		}
		
		public function setAccessGolden (value:int) :void {
			this._accessGolden = value; 
		}
		
		public function setMaxGolden (value:int) :void {
			this._maxGolden = value;
		}
		
		public function getMaxGolden () :int {
			return _maxGolden;
		}
		
		public function setSimpleCount (value:int) :void {
			this._simpleCount = value;
		}
		
		public function getSimpleCount() :int {
			return _simpleCount;
		}
		
		public function setGoldenCount (value:int) :void {
			this._goldenCount = value;
		}
		
		public function getGoldenCount() :int {
			return _goldenCount;
		}
		
		public function setCraftAvailable (value:Boolean) :void {
			this._craftAvailable = value;
		}
		
		public function isCraftAvailable() :Boolean {
			return _craftAvailable;
		}
		
		
		
		
	}

}