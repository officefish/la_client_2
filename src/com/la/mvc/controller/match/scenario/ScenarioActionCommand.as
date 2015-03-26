package com.la.mvc.controller.match.scenario 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.locale.Warning;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.deck.EnemyDeck;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.IAttackAvailable;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.model.CardData;
	import com.la.mvc.view.field.IToken;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioActionCommand extends Command 
	{
		[Inject (name = 'matchModel')]
		public var matchModel:MatchModel; 
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		[Inject (name='field')]
		public var field:IField;
		
		[Inject (name='enemyDeck')]
		public var enemyDeck:EnemyDeck; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='deckModel')]
		public var deckModel:DeckModel;
		
			
		override public function execute():void 
		{
			//console.debug ('scenarioActionCommand::execute');
			var clientId:String = rootModel.userId + " :: " 
			console.debug (clientId + 'scenarioLength: ' + matchModel.scenarioLength)
						
			if (matchModel.scenarioLength) {
				var action:Object = matchModel.getScenarioAction ();
				playAction (action);
			} else {
				playerDeck.unblock();
				if (rootModel.currentState == GameState.OPPONENT_STEP_ACTION) { 
					rootModel.currentState = GameState.OPPONENT_STEP;
				} else if (rootModel.currentState == GameState.PLAYER_STEP_ACTION) {
					rootModel.currentState = GameState.PLAYER_STEP;
				}
			}
		}
		
		private function playAction (data:Object) :void {
					
			var cardData:CardData;
			var card:Card;
			var position:int;
			var endAnimationFlag:Boolean;
			var cardIndex:int;
			var attackUnit:DisplayObject;
			var targetUnit:DisplayObject;
			var initiatorIndex:int;
			var targetIndex:int;
			var attackUnitHealth:int;
			var targetUnitHealth:int;
			var i:int;
			var token:IToken;
			var indexList:Array;
			var index:int;

	
			var clientId:String = rootModel.userId + " :: " 
			console.debug (clientId + 'playAction::' + data.type);
			
			var initiatorDO:DisplayObject;
			var targetDO:DisplayObject;
			var initiatorAttachment:Boolean;
			var targetAttachment:Boolean;
			var clientFlag:Boolean;
			var target:IAttackAvailable;
			var value:int;
			var eventData:Object = {};
			
			switch (data.type) {
				case 'step_price': {
					
					endAnimationFlag = data.endAnimationFlag
					if (data.client == rootModel.userId) {
						playerDeck.price = int(data.price)
						field.setPlayerPrice (data.price, endAnimationFlag, true)
					} else {
						field.setOpponentPrice (data.price, endAnimationFlag, true) 	
					}
					break;
				}
				
				case 'pick_card': {
					cardData = CardData.converToData (data.card)
					if (data.client == rootModel.userId) {
						if (data.attachment) {
							playerDeck.addCard(cardData, true);
						} else {
							enemyDeck.addCard(cardData, true);
						}
					} else {
						if (data.attachment) {
							enemyDeck.addCard(cardData, true);
						} else {
							playerDeck.addCard(cardData, true);
						}
					}
					break;
				}
				
				case 'stop_step_timer': {
					scene.stopStepTimer();
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'step': {
					if (data.client == rootModel.userId) {
						rootModel.currentState = GameState.PLAYER_STEP;
						playerDeck.unblock();
						playerDeck.glowAvailableCards();
						field.setOpponentPrice(0, false, false);	
						field.enableStepButton ();
					} else {
						rootModel.currentState = GameState.OPPONENT_STEP;
						field.disableStepButton();
						field.blockTokens ();
						field.setPlayerPrice (0, false, false)
						playerDeck.block();
						playerDeck.stopGlowCards ();
					}
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'play_card_unit': {
					cardData = CardData.converToData (data.unit);
					position = data.position;
					field.placeUnitRowPosition ();
					endAnimationFlag = data.endAnimationFlag;
										
					if (data.client == rootModel.userId) {
						card = playerDeck.getActualCard ();
						field.playPlayerCardUnit(cardData, position, card, endAnimationFlag);
					} else {
						cardIndex = data.cardIndex;
						card = enemyDeck.getCard (cardIndex);
						var mirrorPosition:Point = new Point (card.x, card.y);
						mirrorPosition = card.parent.localToGlobal (mirrorPosition);
						enemyDeck.removeCardAt (cardIndex);
						field.playOpponentCardUnit(cardData, position, card, mirrorPosition, endAnimationFlag);
					}
					break;
				}
				
				case 'sort_deck': {
					
					endAnimationFlag = data.endAnimationFlag;
					if (data.client == rootModel.userId) {
						console.debug (clientId + 'playerDeck.sort');
						playerDeck.sort (endAnimationFlag, true);
					} else {
						console.debug (clientId + 'enemyDeck.sort');
						console.debug ('cards.count:: ' + enemyDeck.getCardsCount());
						//dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
						enemyDeck.sort (endAnimationFlag, true);
					}
					break;
				}
				
				case 'set_row_length': {
					if (data.client == rootModel.userId) {
						playerDeck.setTokenRowLength (data.length);
					}
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'unblock_deck': {
					//console.debug (clientId + 'action:unblock_deck');
					if (data.client == rootModel.userId) {
						endAnimationFlag = data.endAnimationFlag;
						playerDeck.unblock (endAnimationFlag, true);
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				case 'glow_cards': {
					//console.debug (clientId + 'action:glow_cards');
					if (data.client == rootModel.userId) {
						endAnimationFlag = data.endAnimationFlag;
						playerDeck.glowAvailableCards (endAnimationFlag, true);
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				case 'attack_available': {
					//console.debug (clientId + 'action:attack_available');
					if (data.client == rootModel.userId) {
						//console.debug (data.unitList)
						field.markAttackAvailable (data.unitList, endAnimationFlag, true);
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				case 'glow_units': {
					//console.debug (clientId + 'action:glow_units');
					if (data.client == rootModel.userId) {
						field.glowTokens (endAnimationFlag, true);
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				case 'attack': {
					initiatorIndex = data.initiatorIndex;
					targetIndex = data.targetIndex;
					endAnimationFlag = data.endAnimationFlag;
					
					if (data.client == rootModel.userId) {
						attackUnit = field.getAttackUnit(initiatorIndex, true);
						matchModel.setAttackUnit (attackUnit);
						matchModel.setAttackUnitPosition ((attackUnit as IAttackAvailable).getPosition());
						field.classicAttack (initiatorIndex, targetIndex, true, endAnimationFlag, true);
					} else {
						attackUnit = field.getAttackUnit(initiatorIndex, false);
						matchModel.setAttackUnit (attackUnit);
						matchModel.setAttackUnitPosition ((attackUnit as IAttackAvailable).getPosition());
						field.classicAttack (initiatorIndex, targetIndex, false, endAnimationFlag, true);
					}
					break;
				}
				case 'health_after_attack': {
					initiatorIndex = data.initiatorIndex;
					targetIndex = data.targetIndex;
					attackUnitHealth = data.attackUnitHealth;
					targetUnitHealth = data.targetUnitHealth;
					
					if (data.client == rootModel.userId) {
						attackUnit = field.getAttackUnit(initiatorIndex, true);
						targetUnit = field.getTargetUnit (targetIndex, true);
					} else {
						attackUnit = field.getAttackUnit(initiatorIndex, false);
						targetUnit = field.getTargetUnit (targetIndex, false);
					}
					
					(attackUnit as IAttackAvailable).setHealth (attackUnitHealth);
					(targetUnit as IAttackAvailable).setHealth (targetUnitHealth);
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				case 'attack_complete': {
					endAnimationFlag = data.endAnimationFlag;
					//console.debug(endAnimationFlag.toString())
					field.backUnitToPosition (matchModel.getAttackUnit(), matchModel.getAttackUnitPosition(), endAnimationFlag, true);
					(matchModel.getAttackUnit() as IToken).canAttack = false;
					break;
				}
				
				case 'attack_token_death': {
					initiatorIndex = data.initiatorIndex;
					endAnimationFlag = data.endAnimationFlag;
					if (data.client == rootModel.userId) {
						field.removeToken (initiatorIndex, true, endAnimationFlag, true);
					} else {
						field.removeToken (initiatorIndex, false, endAnimationFlag, true);
					}
					break;
				}
				
				case 'target_token_death': {
					targetIndex = data.targetIndex;
					endAnimationFlag = data.endAnimationFlag;
					if (data.client == rootModel.userId) {
						field.removeToken (targetIndex, false, endAnimationFlag, true);
					} else {
						field.removeToken (targetIndex, true, endAnimationFlag, true);
					}
					break;
				}
				
				case 'jerk': {
					//console.debug('jerk: ' + data.targets);
					indexList = data.targets[0];
					for (i = 0; i < indexList.length; i ++) {
						index = indexList[i]
						if (matchModel.whiteFlag) {
							token = field.getPlayerToken (index);
							token.canAttack = true;
							token.glow();
						} 
					}
					indexList = data.targets[1];
					for (i = 0; i < indexList.length; i ++) {
						index = indexList[i]
						if (!matchModel.whiteFlag) {
							token = field.getPlayerToken (index);
							token.canAttack = true;
							token.glow();
						}
					}
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'provocation': {
					//console.debug('provocation: ' + data.targets);
					indexList = data.targets[0];
					for (i = 0; i < indexList.length; i ++) {
						index = indexList[i]
						if (matchModel.whiteFlag) {
							token = field.getPlayerToken (index);
							token.activateProvocation();
						} else {
							token = field.getOpponentToken (index);
							token.activateProvocation();
						}
					}
					indexList = data.targets[1];
					for (i = 0; i < indexList.length; i ++) {
						index = indexList[i]
						if (matchModel.whiteFlag) {
							token = field.getOpponentToken (index);
							token.activateProvocation();
						} else {
							token = field.getPlayerToken (index);
							token.activateProvocation();
						}
					}
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'provocation_exception': {
					if (data.client == rootModel.userId) {
						scene.darken();
						field.blur();
						scene.addEventListener (SceneEvent.WARNING_CLOSE, onWarningClose);
						scene.warning (Warning.PROVOCATION_WARNING); 
					} 
					break;
				}
				
				case 'opponent_hero_death': {
					break;
				}
				
				case 'play_card_selected': {
					if (data.client == rootModel.userId) {
						cardData = CardData.converToData (data.unit);
						position = data.position;
						field.placeUnitRowPosition ();
						endAnimationFlag = data.endAnimationFlag;
						card = playerDeck.getActualCard ();
						field.playPlayerCardUnit(cardData, position, card, endAnimationFlag);
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				
				
				
				case 'play_card_opponent_selected': {
					if (data.client != rootModel.userId) {
						cardData = CardData.converToData (data.unit);
						position = data.position;
						field.placeUnitRowPosition ();
						endAnimationFlag = data.endAnimationFlag;
						cardIndex = data.cardIndex;
						card = enemyDeck.getCard (cardIndex);
						var mirrorPosition:Point = new Point (card.x, card.y);
						mirrorPosition = card.parent.localToGlobal (mirrorPosition);
						enemyDeck.removeCardAt (cardIndex);
						field.playOpponentCardUnit(cardData, position, card, mirrorPosition, endAnimationFlag);
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				
				case 'select': {
					if (data.client == rootModel.userId) {
						dispatch (new SceneEvent (SceneEvent.SELECT_FOR_EPTITUDE, {'mask':data.select_mask}));
					} 
					//dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'passive_attack': {
					//console.debug(clientId + 'passiveAttack');
					
					targetAttachment = data.targetAttachment;
					targetIndex = data.targetIndex;
					initiatorAttachment = data.initiatorAttachment;
					initiatorIndex = data.initiatorIndex;
					
					clientFlag = data.client == rootModel.userId;
					
					initiatorDO = initUnitbyAttachment (initiatorIndex, initiatorAttachment, clientFlag);
					targetDO = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
										
					dispatch (new SceneEvent (SceneEvent.PASSIVE_ATTACK, { initiator:initiatorDO, target:targetDO } ));
					break;
				}
				
				case 'health_after_passive_attack': {
					targetIndex = data.targetIndex;
					targetAttachment = data.targetAttachment;
					targetUnitHealth = data.targetUnitHealth;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					
					(targetUnit as IAttackAvailable).setHealth (targetUnitHealth);
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				case 'token_death': {
					scene.endCopy();
					targetIndex = data.targetIndex;
					targetAttachment = data.targetAttachment;
					endAnimationFlag = data.endAnimationFlag;
					if (data.client == rootModel.userId) {
						if (targetAttachment) {
							field.removeToken (targetIndex, true, endAnimationFlag, true);
						} else {
							field.removeToken (targetIndex, false, endAnimationFlag, true);
						}
					} else {
						if (targetAttachment) {
							field.removeToken (targetIndex, false, endAnimationFlag, true);
						} else {
							field.removeToken (targetIndex, true, endAnimationFlag, true);
						}
					}
					if (!endAnimationFlag) {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				
				case 'increase_attack_and_health':
				{
					console.debug (clientId + 'increase_attack_and_health: ' + matchModel.scenarioLength)
					targetIndex = data.targetIndex;
					targetAttachment = data.targetAttachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					var power:int = data.power;
					
					var target:IAttackAvailable = targetUnit as IAttackAvailable;
                    target.setMaxHealth (target.getMaxHealth() + power)
					target.setHealth (target.getHealth() + power);
					target.setAttack(target.getAttack() + power)
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'increase_health':
				{
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					value = data.value;
					
					target = targetUnit as IAttackAvailable;
					if (data.maxHealth) {
						target.setMaxHealth(data.maxHealth)
					}
					target.setHealth (value);
					
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'stop_select_mode':
				{
					if (data.client == rootModel.userId) {
						dispatch (new SceneEvent(SceneEvent.SCENARIO_END_SELECT_UNIT, { } ));
					} else {
						dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					}
					break;
				}
				
				case 'back_token_to_hand':
				{
					if (data.opponent_ignore) {
						if (data.client != rootModel.userId) {
							dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
							break;
						}

					}
					targetIndex = data.targetIndex;
					targetAttachment = data.targetAttachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					   
					cardData = CardData.converToData(data.card);
					
					dispatch (new SceneEvent (SceneEvent.BACK_TOKEN_TO_HAND, { 
						token:targetUnit, 
						cardData:cardData,
						targetIndex:targetIndex,
						targetAttachment:targetAttachment,
						clientFlag:clientFlag
					} ));
					break;
				}
				
				case 'opponent_step': {
					scene.stopStepTimer();
		
					rootModel.currentState = GameState.OPPONENT_STEP;

					cardData = CardData.converToData(data.card);
					deckModel.addOpponentCard(cardData);

					field.clearPlayerPrice();
					field.disableStepButton();
					field.blockTokens ();

					enemyDeck.price = data.price;
					enemyDeck.addCard(cardData, true);

					playerDeck.block();
					playerDeck.stopGlowCards ();

					field.setOpponentPrice(enemyDeck.price);
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				case 'new_unit': {
					cardData = CardData.converToData (data.cardData);
					targetAttachment = data.attachment
					targetIndex = data.index
					if (data.client == rootModel.userId) {
						field.addToken (targetAttachment, cardData, targetIndex);
					} else {
						field.addToken (!targetAttachment, cardData, targetIndex);
					}
					
					break;
				}
				
				case 'attack_mixin': {
										
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					power = data.power
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					
					target = targetUnit as IAttackAvailable;
					var attackBob:int = target.getAttackBob();
					attackBob += power;
					target.setAttackBob (attackBob);
					target.setAttack(target.getAttack());
										
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				
				
				case 'treatment':
				{
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.setHealth (data.health);
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'increase_attack':
				{
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.setAttack (data.attack);
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'glow_last_card':
				{
					if (data.client == rootModel.userId) {
						var card:Card = playerDeck.getLastCard();
						var price:int = playerDeck.price
						var cardPrice:int = card.getPrice();
						if (price > cardPrice) {
							if (!playerDeck.getTokenLimitFlag()) {
								playerDeck.glowCard(card);
							}
							
						}
						
					}
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'massive_attack': {
					// field.massiveAttackAnimation();
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'shield':
				{
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.activateShield ();
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'destroy_shield':
				{
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.destroyShield ();
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'shadow': {
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.activateShadow();
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'destroy_shadow': {
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.destroyShadow ();
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				
				case 'shadow_exception': {
					if (data.client == rootModel.userId) {
						scene.darken();
						field.blur();
						scene.addEventListener (SceneEvent.WARNING_CLOSE, onWarningClose);
						scene.warning (Warning.SHADOW_WARNING); 
					} 
					break;
				}
				
				case 'double_attack': {
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.activateDoubleAttack();
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'dumbness':
				{
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
										
					target = targetUnit as IAttackAvailable;
					target.setMaxHealth(target.getDefaultHealth())
					target.setHealth(data.health)
					target.setAttack(data.attack)
					
					target.deactivateDoubleAttack();
					target.destroyShadow();
					target.destroyShield();
					target.deactivateProvocation();
					target.deactivateFreeze();
					
					target.canAttack = data.canAttack;
					
					//target.deactivateFreeze();
					target.dumbness();
					
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'freeze_attack':
				{
					targetAttachment = data.targetAttachment;
					targetIndex = data.targetIndex;
					initiatorAttachment = data.initiatorAttachment;
					initiatorIndex = data.initiatorIndex;
					
					clientFlag = data.client == rootModel.userId;
					
					initiatorDO = initUnitbyAttachment (initiatorIndex, initiatorAttachment, clientFlag);
					targetDO = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
										
					dispatch (new SceneEvent (SceneEvent.FREEZE_ATTACK, { initiator:initiatorDO, target:targetDO } ));
					break;
				}
				
				case 'freeze':
				{
					targetAttachment = data.attachment;
					targetIndex = data.index;
					clientFlag = data.client == rootModel.userId;
					
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					target = targetUnit as IAttackAvailable;
					target.activateFreeze();
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'destroy_freeze': {
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
										
					target = targetUnit as IAttackAvailable;
					target.deactivateFreeze();
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'change_card_price': {
					targetIndex = data.index;
					targetAttachment = data.attachment;
					clientFlag = data.client == rootModel.userId;
					card = initCardbyAttachment (targetIndex, targetAttachment, clientFlag);
					if (card) {
						trace ('changeCardPrice')
						card.setPrice(data.price)
					}
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break;
				}
				
				case 'replace_card_and_token': {
					console.debug ('REPLACE_CARD_AND_TOKEN');
					
					targetAttachment = data.cardAttachment;
					targetIndex = data.cardIndex;
					clientFlag = data.client == rootModel.userId;
					card = initCardbyAttachment (targetIndex, targetAttachment, clientFlag);
					
					targetIndex = data.initiatorIndex;
					targetAttachment = data.initiatorAttachment;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					
					var associate:Boolean = initAssociate(targetAttachment, clientFlag);
					
					cardData = CardData.converToData (data.unit);
					var initiatorCardData:CardData = CardData.converToData (data.card);
				
					eventData['targetCard'] = card;
					eventData['targetToken'] = targetUnit;
					eventData['associate'] = associate;
					eventData['cardData'] = cardData;
					eventData['initiatorCardDara'] = initiatorCardData;
					
					dispatch (new SceneEvent (SceneEvent.REPLACE_CARD_AND_TOKEN, eventData ));
					break;
				}
				
				case 'entice_unit':
				{
					//
					clientFlag = data.client == rootModel.userId;
					targetIndex = data.targetIndex;
					targetAttachment = data.targetAttachment;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					
					eventData['targetToken'] = targetUnit;
					
					dispatch (new SceneEvent (SceneEvent.ENTICE_UNIT, eventData ));
					break;
				}
				
				case 'change_unit':
				{
					clientFlag = data.client == rootModel.userId;
					targetIndex = data.targetIndex;
					targetAttachment = data.targetAttachment;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					
					cardData = CardData.converToData (data.cardData);
					token = field.changeToken(targetUnit as IToken, cardData)
					
					if (data.jerk) {
						token.canAttack = true;
						token.glow();
					}
					if (data.provocation) {
						token.activateProvocation();
					}
					if (data.doubleAttack) {
						token.activateDoubleAttack();
					}
					if (data.shield) {
						token.activateShield()
					}
					if (data.shadow) {
						token.activateShadow()
					}
					if (data.freeze) {
						token.activateFreeze()
					}
					if (data.dumbness) {
						token.dumbness()
					}
					token.setAttack(data.attack);
					token.setHealth(data.health);
					
					
										
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break; 
				}
				
				case 'activate_widget': {
					
					clientFlag = data.client == rootModel.userId;
					targetIndex = data.targetIndex;
					targetAttachment = data.targetAttachment;
					targetUnit = initUnitbyAttachment (targetIndex, targetAttachment, clientFlag);
					
					eventData['targetToken'] = targetUnit;
					dispatch (new SceneEvent (SceneEvent.ACTIVATE_WIDGET, eventData ));
					break;
				}
				
				case 'destroy_actual_card': {
					clientFlag = data.client == rootModel.userId;
					if (clientFlag) {
						playerDeck.destroyActualCard();
					}
					dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
					break; 
				}
					
				
				
					
					
				
			}
		}
		
		private function initCardbyAttachment (index:int, attachment:Boolean, client:Boolean) :Card {
			var _card:Card;
			if (client) {
				if (index >= 0) {
					if (attachment) {
						_card = playerDeck.getCardByIndex(index);
					} else {
						_card = enemyDeck.getCard(index);
					}
				} 
			} else {
				if (index >= 0) {
					if (!attachment) {
						_card = playerDeck.getCardByIndex(index);
					} else {
						_card = enemyDeck.getCard(index);
					}
				} 
			}
			return _card;
		}
		
		private function initAssociate (attachment:Boolean, client:Boolean) :Boolean {
			var associate:Boolean;
			if (client) {
				if (attachment) {
					associate = true;
				} else {
					associate = false;
				}
			} else {
				if (!attachment) {
					associate = true;
				} else {
					associate = false;
				}
			}
			return associate;
		}
		
		private function initUnitbyAttachment (index:int, attachment:Boolean, client:Boolean) :DisplayObject {
			var _do:DisplayObject;
			if (client) {
				if (index >= 0) {
					if (attachment) {
						_do = field.getPlayerToken(index) as DisplayObject;
					} else {
						_do = field.getOpponentToken(index) as DisplayObject;
					}
				} else {
					if (attachment) {
						_do = field.getPlayerHero() as DisplayObject;
					} else {
						_do = field.getOpponentHero() as DisplayObject;;
					}
				}
			} else {
				if (index >= 0) {
					if (attachment) {
						_do = field.getOpponentToken(index) as DisplayObject;
					} else {
						_do = field.getPlayerToken(index) as DisplayObject;
					}
				} else {
					if (attachment) {
						_do = field.getOpponentHero() as DisplayObject;
					} else {
						_do = field.getPlayerHero() as DisplayObject;;
					}
				}
			}
			return _do;
			
		}
		
		private function onWarningClose (event:SceneEvent) :void {
			scene.removeEventListener (SceneEvent.WARNING_CLOSE, onWarningClose);
			scene.lighten (false);
			field.stopBlur();
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}
		
		
      
		
		
	}

}