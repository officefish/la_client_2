package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioEvent extends DataEvent 
	{
		public static const ACTION:String = 'scenarioAction';
		public static const PICK_CARD:String = 'pickCard';
		public static const PLAY_UNIT_CARD:String = 'playUnitCard';
		public static const STEP:String = 'scenarioStep';
		public static const END_STEP:String = 'scenarioEndStep';
		public static const INIT_MANA:String = 'initMana';
		public static const GLOW_CARDS:String = 'glowCards';
		public static const SELECT_TARGET_FOR_APTITUDE:String = 'selectTargetForAptitude';
		public static const BACK_CARD_TO_HAND:String = 'backCardToHand';
		public static const PASSIVE_ATTACK:String = 'passiveAttack';
		public static const FREEZE_ATTACK:String = 'freeseAttack';
		public static const DAMAGE:String = 'damage';
		public static const REMOVE_MINION:String = 'removeMinion';
		public static const MINION_HEALTH:String = 'mimionHealth';
		public static const SEVERAL_MINIONS_HEALTH:String = 'severalMinionsHealth';
		public static const GLOW_MINIONS:String = 'glowMinions';
		public static const CLASSIC_ATTACK:String = 'classicAttack';
		public static const ATTACK_COMPLETE:String = 'attackComplete';
		public static const ATTACK_AVAILABLE:String = 'attackAvailable';
		public static const REMOVE_CARD:String = 'removeCard';
		public static const DESTROY_FREEZE:String = 'destroyFreeze';
		public static const NEW_MINION:String = 'newMinion';
		public static const JERK:String = 'jerk';
		public static const PROVOCATION:String = 'provocation';
		public static const EXCEPTION:String = 'exception';
		public static const SHIELD:String = 'shield';
		public static const DESTROY_SHIELD:String = 'destroyShield';
		public static const CHANGE_ATTACK:String = 'changeAttack';
		public static const INCREASE_SPELL:String = 'increaseSpell';
		public static const DECREASE_SPELL:String = 'decreaseSpell';
		public static const MASSIVE_ATTACK:String = 'massiveAttack';
		public static const MASSIVE_KILL:String = 'massiveKill';
		public static const FREEZE:String = 'freeze';
		public static const ATTACK_MIXIN:String = 'attack_mixin';
		public static const HEALTH:String = 'health';
		public static const SELECT_EFFECT:String = 'selectEffect';
		public static const SELECT_TARGET_FOR_EFFECT:String = 'selectTargetForEffect';
    	public static const SELECT_TARGET_FOR_ACTIVE:String = 'selectTargetForActive';
		public static const ATTACK_AND_HEALTH:String = 'attackAndHealth';
		public static const ACTIVATE_WIDGET:String = 'activateWidget';
		public static const BLOCK_ACTIVE:String = 'blockActive';
		public static const GLOW_MINION:String = 'glowMinion';
		public static const BURN_CARD:String = 'burnCard';
		public static const FATIGUE:String = 'fatigue'; 
		public static const END_MATCH:String = 'endMatch';
		public static const DOUBLE_ATTACK:String = 'doubleAttack';
		public static const DESTROY_DOUBLE_ATTACK:String = 'destroyDoubleAttack';
		public static const SHADOW:String = 'shadow';
		public static const DESTROY_SHADOW:String = 'destroyShadow';
		public static const FLY:String = 'fly';
		public static const DESTROY_FLY:String = 'destroy_fly';
		public static const ATTACH_WIDGET:String = 'attachWidget';
		public static const DESTROY_PROVOCATION:String = 'destroyProvocation';
		public static const CHANGE_CARD_PRICE:String = 'changeCardPrice';
		public static const DECREASE_HEALTH:String = 'decreaseHealth';
		public static const SPELL_INVISIBLE:String = 'spellInvisible';
		public static const DUMBNESS:String = 'dumbness';
		public static const SELECT_TARGET_FOR_SPELL:String = 'selectTargetForSpell';
		public static const TAKE_UP_WEAPON:String = 'takeUpWeapon';
		public static const GLOW_HERO:String = 'glowHero';
		
		public static const GLOW_WEAPON:String = 'glowWeapon';
		public static const STOP_GLOW_WEAPON:String = 'stopGlowWeapon';
		public static const WEAPON_STRENGTH:String = 'weaponStrength';
		public static const DESTOY_WEAPON:String = 'destroyWeapon';
		
		
		public function ScenarioEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new ScenarioEvent(type, data, bubbles, cancelable);
		}
		
	}

}