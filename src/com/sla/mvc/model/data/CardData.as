package com.sla.mvc.model.data 
{
	import com.demonsters.debugger.MonsterDebugger;
	/**
	 * ...
	 * @author 
	 */
	public class CardData 
	{
		
		private var _attack:int;
		private var _health:int;
		
		private var _price:int;
		private var _eptitudes:Array;
		
		private var _maxHealth:int;
		private var _defaultHealth:int;
		private var _defaultAttack:int;
		
		private var _title:String;
		private var _description:String;

        private var raceId:int;
        private var subraceId:int;
		
		private var _race:String;
		private var _subrace:String;

        private var _type:int;
        private var _spellPower:int;

        public static const SPELL:int = 0;
        public static const SECRET:int = 1;
		public static const UNIT:int = 2;
		public static const SPELL_TO_TARGET:int = 3;
		
        private var _id:int;

        private var auxiliaryFlag:Boolean = false;
		
		private var _widget:int = 0;
		
		private var _aptManacost:int = 0;
		
		
		public function CardData(attack:int, health:int, price:int, aptitudes:Array = null) 
		{
			this._attack = attack;
			this._health = health;
			this._maxHealth = health;
			this._defaultHealth = health;
			this._price = price;
			this._eptitudes = aptitudes;
			this._defaultAttack = attack;
			
		}
		
		public function get attack () :int {
			return _attack;
		}
		
		public function get health () :int {
			return _health;
		}
		
		public function get price () :int {
			return _price;
		}
		
		public function set attack (value:int) :void {
			this._attack = value;
		}
		
		public function getEptitudes () :Array {
			if (_eptitudes == null) {
				_eptitudes = [];
			}
			return _eptitudes.concat();
		}
		
		public function set health (value:int) :void {
			this._health = value;
		}
		
		public function set maxHealth (value:int) :void {
			this._maxHealth = value;
		}
		
		public function set defaultHealth (value:int) :void {
			this._defaultHealth = value;
		}
		
		public function get maxHealth () :int {
			return _maxHealth;
		}
		
		public function get defaultHealth () :int {
			return _defaultHealth;
		}
		
		public function get defaultAttack () :int {
			return _defaultAttack;
		}
		
		public function set title (value:String) :void {
			this._title = value;
		}
		
		public function get title () :String {
			return _title;
		}
	
		
		public function set description (value:String) :void {
			_description = value;
		}
		
		public function get description () :String {
			return _description;
		}

        public function  set race (race:String) :void {
            this._race = race;
        }

        public function get race () :String {
            return _race;
        }

        public function  set subrace (subrace:String) :void {
            this._subrace = subrace;
        }

        public function  get subrace () :String {
            return _subrace;
        }

        public function set type (value:int) :void {
            this._type = value;
        }
		public function get type () :int {
            return _type;
        }

        public function set spellPower (value:int) :void {
            this._spellPower = value;
        }
        public function get spellPower () :int {
            return _spellPower;
        }

        public function set auxiliary (value:Boolean) :void {
            auxiliaryFlag = value;
        }

        public function get auxiliary () :Boolean {
            return auxiliaryFlag;
        }

        public function set id (value:int) :void {
            this._id = value;
        }

        public function  get id () :int {
            return _id;
        }
		
		public function set widget (value:int):void {
			_widget = value;
		}
		
		public function get widget () :int {
			return _widget;
		}
		
		public function setAptitudes (apt:Array) :Array {
			
			this._eptitudes = []
			for (var i:int = 0; i < apt.length; i ++) {
				var data:Object = apt[i];
				var eptitude:CardAptitude = new CardAptitude();
				if (data.type) {
					eptitude.setType(data.type);
				}
				if (data.level) {
					eptitude.setLevel(data.level);
				}
				if (data.period) {
					eptitude.setPeriod(data.period);
				}
				if (data.power) {
					eptitude.setPower(data.power);
				}
				if (data.lifecycle) {
					eptitude.setLifecycle(data.lifecycle);
				}
				if (data.condition) {
					eptitude.setCondition(data.condition);
				}
				eptitude.manacost = data.manacost;
				_eptitudes.push (eptitude);
			}
			return _eptitudes;
			
		}
		
		public function getEptitudesData () :String {
			var str:String = '[ ';
			
			for (var i:int = 0; i < _eptitudes.length; i ++) {
				var epritude:CardAptitude = _eptitudes[i] as CardAptitude;
				str += epritude.toString();
			}
			str += ' ]';
			return str;

		}
		
		public function get hasActiveAptitude () :Boolean {
			var bool:Boolean = false;;
			for (var i:int = 0; i < _eptitudes.length; i ++) {
				var eptitude:CardAptitude = _eptitudes[i] as CardAptitude;
				if (eptitude.getPeriod() == 55) {
					_aptManacost = eptitude.manacost;
					bool = true;
					break;
				}
			}
			return bool;
		}
		
		public function get activeManacost () :int {
			return _aptManacost;
		}
		
		public static function converToData (data:Object) :CardData {
		

            var cardData:CardData = new CardData(data.attack, data.health, data.price);
            cardData.id = data.id;
            cardData.title = data.title;
            cardData.description = data.description;
			cardData.setAptitudes (data.eptitudes);
			cardData.type = data.type;
			cardData.widget = data.widget;
			if (data.race) {
				cardData.race = data.race;
			}
			if (data.subrace) {
				cardData.subrace = data.subrace;
			}
			MonsterDebugger.log(cardData.getEptitudesData())
			return cardData;
			
            
        }
	}

}