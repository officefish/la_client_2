package com.la.mvc.model {
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardEptitude
	{
		
		private var _type:int;
		private var _period:int;
		private var _level:int;
		private var _power:int;
		private var _lyfecycle:int;
		private var _condition:int = 0;
		
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
				str += ' period: ' + EptitudePeriod.string(getPeriod())
			}
			if (getLevel() || getLevel() == 0) {
				str += ' level: ' + EptitudeLevel.string(getLevel())
			}
			if (getPower()) {
				str += ' power: ' + getPower() + ', '
			}
			if (getLifecycle()) {
				str += ' lifecycle: ' + getLifecycle()
			}
			str += ' ]'
			return str;
								   							
		}
	}

}