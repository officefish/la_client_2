package com.sla.mvc.model 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.data.AbilityData;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.field.minion.IMinion;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MatchModel extends Actor 
	{
		private var _matchId:int;
		private var _mode:int;
		private var _playerHero:int;
		private var _opponentHero:int;
		private var _playerHeroHealth:int;
		private var _opponentHeroHealth:int;
		private var _whiteFlag:Boolean;
		private var _preflopEndFlag:Boolean = false;
		private var scenario:Array;
		private var _controlFlag:Boolean;
		private var _block:Boolean = false;
		private var  _dragMode:Boolean = false; 
		private var _mana:int;
		private var _numMinions:int;
		private var _attackMinion:IMinion;
		private var _spellMixin:int = 0;
		private var _drawingCard:Card;
		
		private var _playerAbilities:Vector.<AbilityData>;
		private var _opponentAbilities:Vector.<AbilityData>
		
		public function setSpellMixin (value:int) :void {
			this._spellMixin = value;
		}
		public function getSpellMixin () :int {
			return _spellMixin;
		}
		public function set drawingCard (value:Card) :void {
			_drawingCard = value;
		}
		public function get drawingCard () :Card {
			return _drawingCard;
		}
		
		public function set dragMode (value:Boolean) :void {
			_dragMode = value;
		}
		public function get dragMode () :Boolean {
			return _dragMode;
		}
		
		public function set block (value:Boolean) :void {
			_block = value;
		}
		public function get block () :Boolean {
			return _block;
		}
		
		public function setScenario (scenario:Array) :void {
			this.scenario = scenario;
		}
	
		public function clear () :void {
			this.scenario = [];
			_controlFlag = false;
			preflopEndFlag = false;
		}
	
		public function concatScenario (scenario:Array) :void {
			this.scenario = this.scenario.concat(scenario);
		}
	
		public function get scenarioLength () :int {
			if (scenario) {
				return scenario.length;
			} else {
				return 0;
			}
		}
		
		public function getScenarioAction () :Object {
			return scenario.shift();
		}
		
		public function set matchId (value:int) :void {
			_matchId = value;
		}
		public function get matchId () :int {
			return _matchId;
		}
		
		public function set mode (value:int) :void {
			_mode = value;
		}
		public function get mode () :int {
			return _mode;
		}
		
		public function set playerHero (value:int) :void {
			_playerHero = value;
		}
		public function get playerHero () :int {
			return _playerHero;
		}
		
		public function set opponentHero (value:int) :void {
			_opponentHero = value;
		}
		public function get opponentHero () :int {
			return _opponentHero;
		}

		public function set playerHeroHealth (value:int) :void {
			_playerHeroHealth = value;
		}
		public function get playerHeroHealth () :int {
			return _playerHeroHealth;
		}

		public function set opponentHeroHealth (value:int) :void {
			_opponentHeroHealth = value;
		}
		public function get opponentHeroHealth () :int {
			return _opponentHeroHealth;
		}
		
		public function set whiteFlag (value:Boolean) :void {
			this._whiteFlag = value;
		}
		public function get whiteFlag () :Boolean {
			return _whiteFlag;
		}

		public function set preflopEndFlag (value:Boolean) :void {
			_preflopEndFlag = value;
		}
		public function get preflopEndFlag () :Boolean {
			return _preflopEndFlag;
		}
		
		public function set mana (value:int) :void {
			_mana = value;
		}
		public function get mana () :int {
			return _mana;
		}
		public function set numMinions (value:int) :void {
			_numMinions = value;
		}
		public function get numMinions () :int {
			return _numMinions;
		}
		public function set attackMinion (value:IMinion) :void {
			_attackMinion = value;
		}
		public function get attackMinion () :IMinion {
			return _attackMinion;
		}
		
		public function initAbilities(vector:Vector.<AbilityData>, list:Array) :void {
		
			var _abilityData:AbilityData; 
			var _responseData:Object;
			for (var i:int = 0; i < list.length; i ++) {
				_responseData = list[i];
				_abilityData = new AbilityData();
				_abilityData.title = _responseData.data.title;
				_abilityData.description = _responseData.data.description;
				_abilityData.price = _responseData.data.price;
				_abilityData.autonomic = _responseData.data.autonomic;
				_abilityData.type = _responseData.data.type;
				_abilityData.position = _responseData.position;
				MonsterDebugger.log ('attachment:' +  _responseData.data.attachment) 
				MonsterDebugger.log ('attachHero:' +  _responseData.data.attach_hero) 

				_abilityData.attachHero = _responseData.data.attach_hero;
				_abilityData.attachment = _responseData.data.attachment;
			
				vector.push(_abilityData)
			}
		}
		
		public function initPlayerAbilities(list:Array) :void {
			_playerAbilities = new Vector.<AbilityData>();
			initAbilities(_playerAbilities, list)
		}
		
		public function initOpponentAbilities(list:Array) :void {
			_opponentAbilities = new Vector.<AbilityData>();
			initAbilities(_opponentAbilities, list)
		}
		
		public function get playerAbilities () :Vector.<AbilityData> {
			return _playerAbilities;
		}
		public function get opponentAbilities () :Vector.<AbilityData> {
			return _opponentAbilities;
		}

		
	}

}