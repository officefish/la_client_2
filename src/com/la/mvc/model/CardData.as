package com.la.mvc.model 
{
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

        private var type:int;

        private var spellPower:int;

        public static const SPELL:int = 0;
        public static const SECRET:int = 1;
		public static const UNIT:int = 2;

        private var _id:int;

        private var auxiliaryFlag:Boolean = false;
		
		
		
		public function CardData(attack:int, health:int, price:int, eptitudes:Array = null) 
		{
			this._attack = attack;
			this._health = health;
			this._maxHealth = health;
			this._defaultHealth = health;
			this._price = price;
			this._eptitudes = eptitudes;
			this._defaultAttack = attack;
		}
		
		public function getAttack () :int {
			return _attack;
		}
		
		public function getHealth () :int {
			return _health;
		}
		
		public function getPrice () :int {
			return _price;
		}
		
		public function setAttack (value:int) :void {
			this._attack = value;
		}
		
		public function getEptitudes () :Array {
			if (_eptitudes == null) {
				_eptitudes = [];
			}
			return _eptitudes.concat();
		}
		
		public function setHealth (value:int) :void {
			this._health = value;
		}
		
		public function setMaxHealth (value:int) :void {
			this._maxHealth = value;
		}
		
		public function setDefaultHealth (value:int) :void {
			this._defaultHealth = value;
		}
		
		public function getMaxHealth () :int {
			return _maxHealth;
		}
		
		public function getDefaultHealth () :int {
			return _defaultHealth;
		}
		
		public function getDefaultAttack () :int {
			return _defaultAttack;
		}
		
		public function setTitle (value:String) :void {
			this._title = value;
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

        public function  setRace (race:String) :void {
            this._race = race;
        }

        public function getRace () :String {
            return _race;
        }

        public function  setSubrace (subrace:String) :void {
            this._subrace = subrace;
        }

        public function  getSubrace () :String {
            return _subrace;
        }

        public function setType (value:int) :void {
            this.type = value;
        }
		public function getType () :int {
            return type;
        }

        public function setSpellPower (value:int) :void {
            this.spellPower = value;
        }
        public function getSpellPower () :int {
            return spellPower;
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
		
		public function setEptitudes (ept:Array) :void {
			this._eptitudes = []
			for (var i:int = 0; i < ept.length; i ++) {
				var data:Object = ept[i];
				var eptitude:CardEptitude = new CardEptitude();
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
				_eptitudes.push (eptitude);
			}
		}
		
		public function getEptitudesData () :String {
			var str:String = '[ ';
			for (var i:int = 0; i < _eptitudes.length; i ++) {
				var epritude:CardEptitude = _eptitudes[i] as CardEptitude;
				str += epritude.toString();
			}
			str += ' ]';
			return str;

		}
		
		public static function converToData (data:Object) :CardData {
			var attack:int = data.attack;
            var health:int = data.health;
            var price:int = data.price;
            var title:String = data.title;
            var description:String = data.description;

            var cardData:CardData = new CardData(attack, health, price);
            cardData.id = data.id;
            cardData.setTitle(title);
            cardData.setDescription(description);
			cardData.setEptitudes (data.eptitudes);
			cardData.setType (data.type);
			if (data.race) {
				cardData.setRace (data.race);
			}
			if (data.subrace) {
				cardData.setSubrace (data.subrace);
			}
			trace ('card.type:' + cardData.getType().toString());
			return cardData;
            
        }
	}

}