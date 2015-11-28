package com.sla.mvc.model.data 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardAptitude 
	{
		
		private var _type:int;
		private var _period:int;
		private var _level:int;
		private var _power:int;
		private var _lyfecycle:int;
		private var _condition:int = 0;
		private var _manacost:int = 0;
		private var _attachment:int;
		private var _attachHero:Boolean;
		
		public function setType (value:int) :void {
			this._type = value;
		}
		public function setPeriod (value:int) :void {
			this._period = value;
		}
		public function setLevel (value:int) :void {
			this._level = value;
		}
		public function setPower (value:int) :void {
			this._power = value;
		}
		
		public function setLifecycle (value:int) :void {
			this._lyfecycle = value;
		}
		
		public function getType () :int {
			return _type;
		}
		
		public function getPeriod() :int {
			return _period;
		}
		
		public function getLevel() :int {
			return _level;
		}
		
		public function getPower() :int {
			return _power;
		}
		
		public function getLifecycle() :int {
			return _lyfecycle;
		}
		public function set manacost (value:int) :void {
			this._manacost = value;
		}
		
		public function get manacost () :int {
			return _manacost;
		}
		public function set attachment (value:int) :void {
			this._attachment = value;
		}
		
		public function get attachment () :int {
			return _attachment;
		}
		
		public function set attachHero (value:Boolean) :void {
			this._attachHero = value;
		}
		
		public function get attachHero () :Boolean {
			return _attachHero;
		}
		
		public function setCondition (value:int) :void {
			_condition = value;
		}
		
		public function getCondition () :int {
			return _condition;
		}
		
		public function toString() :String {
			var str:String =  '[CardEptitude ' 
			if (getType()) {
				str += ' type: ' + EptitudeType.string(getType()) 
			}
			if (getPeriod() || getPeriod() == 0) {
				str += '. period: ' + EptitudePeriod.string(getPeriod())
			}
			if (getLevel() || getLevel() == 0) {
				str += '. level: ' + EptitudeLevel.string(getLevel())
			}
			if (getPower()) {
				str += '. power: ' + getPower()  
			}
			if (getLifecycle()) {
				str += '. lifecycle: ' + getLifecycle()
			}
			if (manacost) {
				str += '. manacost: ' + manacost;
			}
			str += ' ]'
			return str;
								   							
		}
		
	}

}