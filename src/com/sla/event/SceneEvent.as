package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SceneEvent extends DataEvent 
	{
		
		public static const CHANGE_PREFLOP:String = 'replacePreflop';
		public static const PREFLOP_INIT:String = 'preflopInit';
		public static const PREFLOP_COMPLETE:String = 'preflopComplete';
		public static const WELCOME_COMPLETE:String = 'welcomeAnimationComplete';
		public static const LIGHTEN_COMPLETE:String = 'lightenComplete';
		public static const WARNING_CLOSE:String = 'warningClose';
		public static const WARNING_CANCEL:String = 'warningCancel';
		public static const WARNING_CONFIRM:String = 'warningConfirm';
		
		public static const SELECT_FOR_EPTITUDE:String = 'selectForEptitude';
		public static const SELECT_FOR_APTITUDE_INIT:String = 'selectForEptitudeInit';
		public static const SELECT_FOR_ATTACK_INIT:String = 'selectForAttackInit';
		public static const SELECT_FOR_SPELL_INIT:String = 'selectForSpellInit';
		public static const CANCEL_SELECT_FOR_APTITUDE_UNIT:String = 'cancelSelectForEptitudeUnit';
		public static const SCENARIO_END_SELECT_UNIT:String = 'scenarioEndSelectUnit';
		
		public static const PASSIVE_ATTACK:String = 'passiveAttack';
		public static const FREEZE_ATTACK:String = 'freeze'
		
		public static const BACK_TOKEN_TO_HAND:String = 'backTokenToHand';
		public static const REPLACE_CARD_AND_TOKEN:String = 'replaceCardAndToken';
		public static const ENTICE_UNIT:String = 'enticeUnit';
		
		public static const ACTIVATE_WIDGET:String = 'activate_widget';
		public static const INCREASE_SPELL:String = 'increaseSpell';
		public static const DECREASE_SPELL:String = 'decreaseSpell';
		public static const CHANGE_MANA:String = 'changeMana';
		
		public static const PASSIVE_ATTACK_FOR_SEVERAL_TARGETS:String = 'passiveAttackForSeveral'
		
		public static const ACTIVATE_DRAWING_SERIES:String = 'activateDrawingSeries';
		public static const DEACTIVATE_DRAWING_SERIES:String = 'deactivateDrawingSeries';
		
		public static const OVERLOAD:String = 'overload';
		public static const CLEAR_OVERLOAD:String = 'clear_overload';
		
		public static const DROP_CARDS:String = 'drop_cards';
		public static const SELECT_EFFECT:String = 'select_effect';
		public static const EFFECT_SELECTED:String = 'effectSelected';
		public static const SELECT_TARGET_FOR_EFFECT:String = 'selectTargetForEffect';
		
		public static const SELECT_GUISE:String = 'select_guise'
		public static const GUISE_SELECTED:String = 'guise_selected';
		public static const UNIT_FROM_HAND:String = 'unit_from_hand';
		
		public static const DAMAGE:String = 'damage';
		public static const MASSIVE_KILL:String = 'massive_kill';
		public static const SHUFFLE_UNIT_INTO_DECK:String = 'shuffleUnitIntoDeck'; 
		public static const BACK_SEVERAL_TOKENS_TO_HAND:String = 'backSeveralTokensToHand';
		public static const COPY_UNIT_CARDS_TO_HAND:String = 'copyUnitCardsToHand';
		public static const BURN_CARD:String = 'burnCard';
		public static const ATTRITION:String = 'attrition';
		public static const END_MATCH:String = 'endMatch';
		
		public static const INCREMENT_ACHIEVE:String = 'incrementAchieve';
		public static const DISABLE_ACHIEVE:String = 'disableAchieve';
		public static const ENABLE_ACHIEVE:String = 'enableAchieve';
		
		public static const START_HAND_CARDS_INIT:String = 'startHandCardsInit';
		public static const PREFLOP_CLICK:String = 'preflopCardClick';
		
		public static const INIT_ATTACK_TARGET:String = 'initAttackTarget';
		public static const TARGET_FOR_EFFECT_SELLECTED:String = 'targetForEffectSelected';
		
		public static const ACTION_POPUP:String = 'actionPopup';
		public static const ACTIVATE_ACTIVE:String = 'activateActive';
		
		public function SceneEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new SceneEvent(type, data, bubbles, cancelable);
		}
		
	}

}