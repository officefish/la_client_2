package com.sla.mvc.controller.match.scenario 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.exeption.ScenarioExeption;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioActionCommand extends StarlingCommand 
	{
		[Inject]
		public var rootModel:RootModel; 
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var matchModel:MatchModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log('ScenarioActionCommand::execute()');
			var clientId:String = rootModel.lobbyId + " :: " 
			MonsterDebugger.log (clientId + 'scenarioLength: ' + matchModel.scenarioLength);
			
			if (matchModel.scenarioLength) {
				var action:Object = matchModel.getScenarioAction ();
				playAction (action);
			} else {
				
				if (stateModel.state == GameState.OPPONENT_STEP_ACTION) {  
					stateModel.state = GameState.OPPONENT_STEP;
				} else if (stateModel.state == GameState.PLAYER_STEP_ACTION) {
					stateModel.state = GameState.PLAYER_STEP;
				}
				
				if (stateModel.state == GameState.PLAYER_STEP) {
					matchModel.block = false;
				}
				//MonsterDebugger.log ('currentSate:' + rootModel.currentState)
						
			}
			
		}
		
		public function playAction (data:Object) :void {
			var clientId:String = rootModel.lobbyId + " :: " 
			MonsterDebugger.log (clientId + 'playAction::' + data.type);
			
			var actionData:Object = { };
			
			switch (data.type) {
				case 'attack_available': {
					actionData.client = getClientFlag(data.client);
					actionData.minions = data.unitList;
					if (actionData.client) {
						dispatch (new ScenarioEvent(ScenarioEvent.ATTACK_AVAILABLE, actionData));
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				case 'damage': {
					actionData.client = getClientFlag(data.client);
					actionData.targets = data.targets;
					dispatch(new ScenarioEvent (ScenarioEvent.DAMAGE, actionData))
					break;
				}
				case 'step_price': {
					actionData.client = getClientFlag(data.client);
					actionData.mana = int(data.price);
					actionData.overload = data.overload;
					dispatch (new ScenarioEvent(ScenarioEvent.INIT_MANA, actionData));
					break;
				}
				case 'step': {
					actionData.client = getClientFlag(data.client);
					dispatch (new ScenarioEvent(ScenarioEvent.STEP, actionData));
					break;
				}
				case 'attrition': {
					actionData.damage = data.damage;
					dispatch(new ScenarioEvent(ScenarioEvent.FATIGUE, actionData))
					break;
				}
				case 'burn_card': {
					actionData.client = getClientFlag(data.client);
					actionData.card = CardData.converToData(data.card);
					actionData.attachment = data.attachment;
					dispatch(new ScenarioEvent(ScenarioEvent.BURN_CARD, actionData))
					break;
				}
				case 'pick_card': {
					actionData.card = CardData.converToData(data.card);
					actionData.client = getClientFlag(data.client);
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent(ScenarioEvent.PICK_CARD, actionData));
					break;
				}
				case 'play_card_unit': {
					actionData.cardData = CardData.converToData (data.unit);
					actionData.position = data.position;
					actionData.client = getClientFlag(data.client);
					actionData.cardIndex = data.cardIndex;
					dispatch (new ScenarioEvent(ScenarioEvent.PLAY_UNIT_CARD, actionData));
					break;
				}
				case 'new_unit': {
					actionData.cardData = CardData.converToData (data.cardData);
					actionData.client = getClientFlag(data.client);
					actionData.attachment = data.attachment;
					actionData.index = data.index;
					dispatch (new ScenarioEvent(ScenarioEvent.NEW_MINION, actionData));
					break;
				}
				case 'play_card_selected': {
					actionData.cardData = CardData.converToData (data.unit);
					actionData.position = data.position;
					actionData.client = getClientFlag(data.client);
					actionData.cardIndex = data.cardIndex;
					if (actionData.client) {
						dispatch (new ScenarioEvent(ScenarioEvent.PLAY_UNIT_CARD, actionData));
					} else {
						dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
					}
					
					break;
				}
				case 'play_card_opponent_selected': {
					actionData.cardData = CardData.converToData (data.unit);
					actionData.position = data.position;
					actionData.client = getClientFlag(data.client);
					actionData.cardIndex = data.cardIndex;
					if (!actionData.client) {
						dispatch (new ScenarioEvent(ScenarioEvent.PLAY_UNIT_CARD, actionData));
					} else {
						dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
					}
					break;
				}
				case 'select': {
					actionData.client = getClientFlag(data.client);
					actionData.mask = data.select_mask;
					dispatch(new ScenarioEvent(ScenarioEvent.SELECT_TARGET_FOR_APTITUDE, actionData));
					break;
				}
				case 'glow_cards': {
					actionData.client = getClientFlag(data.client);
					dispatch(new ScenarioEvent (ScenarioEvent.GLOW_CARDS, actionData));
					break;
				}
				case 'back_token_to_hand': {
					actionData.client = getClientFlag(data.client);
					if (!actionData.client && data.opponent_ignore) {
						dispatch(new ScenarioEvent (ScenarioEvent.GLOW_CARDS, actionData));
						break;
					}
					
					actionData.targetIndex = data.targetIndex;
					actionData.targetAttachment = data.targetAttachment;
					actionData.cardData = CardData.converToData (data.card);
					dispatch(new ScenarioEvent (ScenarioEvent.BACK_CARD_TO_HAND, actionData));
					break;
					
				}
				case 'increase_attack':
				{
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.attack = data.attack;
					dispatch (new ScenarioEvent (ScenarioEvent.CHANGE_ATTACK, actionData));
					break;
				}
				
				case 'passive_attack': {
					actionData.client = getClientFlag(data.client);
					actionData.targetIndex = data.targetIndex;
					actionData.targetAttachment = data.targetAttachment;
					actionData.initiatorAttachment = data.initiatorAttachment;
					actionData.initiatorIndex = data.initiatorIndex;
					dispatch (new ScenarioEvent (ScenarioEvent.PASSIVE_ATTACK, actionData));
					break;
				}
				case 'freeze_attack':
				{
					actionData.client = getClientFlag(data.client);
					actionData.targetIndex = data.targetIndex;
					actionData.targetAttachment = data.targetAttachment;
					actionData.initiatorAttachment = data.initiatorAttachment;
					actionData.initiatorIndex = data.initiatorIndex;
					actionData.animation = data.animation;
					dispatch (new ScenarioEvent (ScenarioEvent.FREEZE_ATTACK, actionData));
					break;
				}
				case 'massive_attack': {
					actionData.client = getClientFlag(data.client);
					actionData.targets = data.targets;
					dispatch (new ScenarioEvent (ScenarioEvent.MASSIVE_ATTACK, actionData));
					break;
				}
				case 'massive_kill': {
					actionData.client = getClientFlag(data.client);
					actionData.targets = data.targets;
					dispatch (new ScenarioEvent (ScenarioEvent.MASSIVE_KILL, actionData));
					break;
				}
				case 'token_death': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					dispatch(new ScenarioEvent(ScenarioEvent.REMOVE_MINION, actionData));
					break;
				}
				case 'attack_token_death': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.initiatorIndex;
					actionData.attachment = data.initiatorAttachment;
					//dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
					dispatch(new ScenarioEvent(ScenarioEvent.REMOVE_MINION, actionData));
					break;
				}
				case 'target_token_death': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					dispatch(new ScenarioEvent(ScenarioEvent.REMOVE_MINION, actionData));
					break;
				}
				
				case 'health_after_passive_attack': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					actionData.health = data.targetUnitHealth;
					actionData.maxHealth = 0;
					dispatch(new ScenarioEvent(ScenarioEvent.MINION_HEALTH, actionData));
					break;
				}
				case 'glow_units':
				{
					actionData.client = getClientFlag(data.client);
					dispatch(new ScenarioEvent(ScenarioEvent.GLOW_MINIONS, actionData));
					break;
				}
				case 'attack': {
					actionData.initiatorIndex = data.initiatorIndex;
					actionData.targetIndex = data.targetIndex;
					actionData.client = getClientFlag(data.client);
					
					dispatch (new ScenarioEvent(ScenarioEvent.CLASSIC_ATTACK, actionData));
					break;
				}
				case 'attack_complete': {
					dispatch (new ScenarioEvent(ScenarioEvent.ATTACK_COMPLETE))
					break;
				}
				case 'health_after_attack': {
					actionData.client = getClientFlag(data.client);
					actionData.targets = 
					[
						{index:data.initiatorIndex, attachment:data.initiatorAttachment, health:data.attackUnitHealth },
						{index:data.targetIndex, attachment:data.targetAttachment, health:data.targetUnitHealth },

					]
					dispatch (new ScenarioEvent (ScenarioEvent.SEVERAL_MINIONS_HEALTH, actionData));
					break;
				}
				case 'decrease_health': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.health = data.health;
					actionData.maxHealth = data.maxHealth;
					dispatch (new ScenarioEvent (ScenarioEvent.DECREASE_HEALTH, actionData));
					break;
				}
				case 'destroy_actual_card': {
					actionData.client = getClientFlag(data.client);
					actionData.cardIndex = data.cardIndex;
					actionData.enemy = data.enemy;
					dispatch (new ScenarioEvent(ScenarioEvent.REMOVE_CARD, actionData));
					break; 
				}
				case 'freeze':
				{
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.FREEZE, actionData));
					break;
				}
				case 'destroy_freeze': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.DESTROY_FREEZE, actionData));
					break;
				}
				case 'shield':
				{
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.SHIELD, actionData));
					break;
				}
				case 'destroy_shield':
				{
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.DESTROY_SHIELD, actionData));
					break;
				}
				case 'shadow': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.SHADOW, actionData));
					break;
				}
				case 'destroy_shadow': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.DESTROY_SHADOW, actionData));
					break;
				}
				
				case 'jerk': {
					actionData.client = getClientFlag(data.client);
					actionData.targets = data.targets;
					dispatch (new ScenarioEvent (ScenarioEvent.JERK, actionData));
					break;
				}
				case 'double_attack': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.DOUBLE_ATTACK, actionData));
					break;
				}
				case 'destroy_double_attack': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.DESTROY_DOUBLE_ATTACK, actionData));
					break;
				}
				case 'provocation': {
					actionData.client = getClientFlag(data.client);
					actionData.targets = data.targets;
					dispatch (new ScenarioEvent (ScenarioEvent.PROVOCATION, actionData));
					break;
				}
				case 'provocation_exception': {
					actionData.client = getClientFlag(data.client);
					actionData.exception = ScenarioExeption.PROVOCATION;
					actionData.backCard = false;
					dispatch (new ScenarioEvent (ScenarioEvent.EXCEPTION, actionData));
					break;
				}
				case 'spell_target_warning': {
					actionData.client = getClientFlag(data.client);
					actionData.exception = ScenarioExeption.SPELL_INVISIBLE;
					actionData.backCard = true;
					dispatch (new ScenarioEvent (ScenarioEvent.EXCEPTION, actionData));
					break;
				}
				case 'dumbness': {
					actionData.client = getClientFlag(data.client);
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.attack = data.attack;
					actionData.health = data.health;
					dispatch (new ScenarioEvent (ScenarioEvent.DUMBNESS, actionData));
					break;
				}
				case 'increase_spell': {
					actionData.client = getClientFlag(data.client);
					actionData.spellClient = getClientFlag(data.spellClient); 
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					actionData.spellMixin = data.spellMixin;
					dispatch (new ScenarioEvent (ScenarioEvent.INCREASE_SPELL, actionData));
					break;
				}
				case 'decrease_spell': {
					actionData.client = getClientFlag(data.client);
					actionData.spellClient = getClientFlag(data.spellClient); 
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					actionData.spellMixin = data.spellMixin;
					dispatch (new ScenarioEvent (ScenarioEvent.DECREASE_SPELL, actionData));
					break;
				}
				case 'attack_mixin': {
					actionData.client = getClientFlag(data.client);					
					actionData.power = data.power;
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.ATTACK_MIXIN, actionData));
					break;
				}
				case 'treatment':
				{
					actionData.client = getClientFlag(data.client);	
					actionData.health = data.health;
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.maxHealth = 0;
					dispatch (new ScenarioEvent (ScenarioEvent.MINION_HEALTH, actionData));
					break;
				}
				case 'fly':
				{
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.FLY, actionData));
					break;
				}
				case 'destroy_fly':
				{
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch (new ScenarioEvent (ScenarioEvent.DESTROY_FLY, actionData));
					break;
				}
				case 'attach_widget':
				{
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.widget = data.widget;
					dispatch (new ScenarioEvent (ScenarioEvent.ATTACH_WIDGET, actionData));
					break;
				}
				case 'change_health':
				{
					actionData.client = getClientFlag(data.client);	
					actionData.health = data.health;
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.maxHealth = data.maxHealth;
					dispatch (new ScenarioEvent (ScenarioEvent.MINION_HEALTH, actionData));
					break;
				}
				case 'increase_attack_and_health':
				{
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					actionData.power = data.power;
					dispatch(new ScenarioEvent(ScenarioEvent.ATTACK_AND_HEALTH, actionData));
					break;
				}
				case 'activate_widget': {
					
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					dispatch(new ScenarioEvent(ScenarioEvent.ACTIVATE_WIDGET, actionData));
					break;
				}
				case 'destroy_provocation': {
					
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch(new ScenarioEvent(ScenarioEvent.DESTROY_PROVOCATION, actionData));
					break;
				}
				case 'select_effect':
				{
					actionData.client = getClientFlag(data.client);	
					var selectCards:Array = [];
					var dataCards:Array = data.cards;
					var cardData:CardData
					for (var i:int = 0; i < dataCards.length; i ++) {
						cardData = CardData.converToData (dataCards[i]);
						selectCards.push(cardData)
					}
					actionData.cards = selectCards;
					dispatch (new ScenarioEvent (ScenarioEvent.SELECT_EFFECT, actionData ));
					break;
				}
				case 'select_for_effect':
				{
					actionData.client = getClientFlag(data.client);	
					actionData.mask = data.select_mask
					dispatch (new ScenarioEvent (ScenarioEvent.SELECT_TARGET_FOR_EFFECT, actionData ));
					break;
				}
				case 'select_active_target': {
					actionData.client = getClientFlag(data.client);	
					actionData.mask = data.mask;
					dispatch (new ScenarioEvent (ScenarioEvent.SELECT_TARGET_FOR_ACTIVE, actionData ));
					break;
				}
				case 'select_for_spell': {
					MonsterDebugger.log ('selectForSpell')
					actionData.client = getClientFlag(data.client);	
					actionData.mask = data.mask;
					dispatch (new ScenarioEvent (ScenarioEvent.SELECT_TARGET_FOR_SPELL, actionData ));
					break;
				}
				case 'block_active': {
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					dispatch(new ScenarioEvent(ScenarioEvent.BLOCK_ACTIVE, actionData));
					break;
				}
				case 'glow_unit': {
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.canAttack = data.canAttack;
					dispatch(new ScenarioEvent(ScenarioEvent.GLOW_MINION, actionData));
					break;
				}
				case 'glow_hero': {
					actionData.client = getClientFlag(data.client);	
					dispatch(new ScenarioEvent(ScenarioEvent.GLOW_HERO, actionData));
					break;
				}
				case 'change_card_price': {
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.index;
					actionData.attachment = data.attachment;
					actionData.price = data.price;
					dispatch (new ScenarioEvent (ScenarioEvent.CHANGE_CARD_PRICE, actionData));
					break;
				}
				case 'spell_invisible': {
					actionData.client = getClientFlag(data.client);	
					actionData.index = data.targetIndex;
					actionData.attachment = data.targetAttachment;
					dispatch(new ScenarioEvent(ScenarioEvent.SPELL_INVISIBLE, actionData));
					break;
				}
				
				case 'take_up_weapon':
					{
					actionData.client = getClientFlag(data.client);	
					actionData.playerWeaponIndex = data.playerWeaponIndex;
					actionData.opponentWeaponIndex = data.opponentWeaponIndex;
					actionData.weaponId = data.weaponId;
					actionData.power = data.power;
					actionData.strength = data.strength;
					
					dispatch (new ScenarioEvent (ScenarioEvent.TAKE_UP_WEAPON, actionData));
					break;
					}
				
				case 'glow_weapon': {
					actionData.client = getClientFlag(data.client);	
					actionData.attachment = data.attachment;
					actionData.weaponIndex = data.weaponIndex;
					dispatch (new ScenarioEvent (ScenarioEvent.GLOW_WEAPON, actionData));
					break;
				}
				case 'stop_glow_weapon': {
					actionData.client = getClientFlag(data.client);	
					actionData.attachment = data.attachment;
					actionData.weaponIndex = data.weaponIndex;
					dispatch (new ScenarioEvent (ScenarioEvent.STOP_GLOW_WEAPON, actionData));
					break;
				}
				case 'destroy_weapon': {
					actionData.client = getClientFlag(data.client);	
					actionData.attachment = data.attachment;
					actionData.weaponIndex = data.weaponIndex;
					dispatch (new ScenarioEvent (ScenarioEvent.DESTOY_WEAPON, actionData));
					break;
				}
				case 'weapon_strength': {
					actionData.client = getClientFlag(data.client);	
					actionData.attachment = data.attachment;
					actionData.weaponIndex = data.weaponIndex;
					actionData.strength = data.strength;
					dispatch (new ScenarioEvent (ScenarioEvent.WEAPON_STRENGTH, actionData));
					break;
				}
					
				case 'end_match': {
					actionData.client = getClientFlag(data.client);	
					actionData.playerWin = data.playerWin;
					actionData.opponentWin = data.opponentWin;
					dispatch(new ScenarioEvent(ScenarioEvent.END_MATCH, actionData));
					break;
				}
				case 'enable_achieve': {
					actionData.client = getClientFlag(data.client);	
					actionData.position = data.position;
					dispatch(new  AbilityEvent(AbilityEvent.ENABLE_ABILITY, actionData))
					break;
				}
				
				case 'disable_achieve': {
					actionData.client = getClientFlag(data.client);	
					actionData.position = data.position;
					dispatch(new  AbilityEvent(AbilityEvent.DISABLE_ABILITY, actionData))
					break;
				}
					
				
				case 'increment_achieve': {
					actionData.client = getClientFlag(data.client);	
					actionData.position = data.position;
					actionData.increment = data.increment;
					actionData.enable = data.enable;
					dispatch(new AbilityEvent(AbilityEvent.INCREMENT_ABILITY, actionData))
					break;
				}
				
				
					
				
				default: {
					dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
				}
			}
		}
		
		private function getClientFlag (client:int) :Boolean {
			return client == rootModel.lobbyId;
						
		}
	}

}