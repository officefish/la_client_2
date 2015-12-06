package com.sla.event 
{
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityEvent extends DataEvent 
	{
		
		public static const STARTUP:String = 'startupAbility';
		public static const CHOOSE_HERO_FOR_CRAFT:String = 'chooseHeroForCraft';
		public static const HERO_SELECT:String = 'heroSelect';
		public static const REMOVE_ABILITY:String = 'removeAbility';
		public static const ADD_ABILITY:String = 'addAbility';
		public static const SAVE_ABILITIES:String = 'aSaveAbilities';
		public static const CRAFT:String = 'craftAbilities';
		public static const PREVIEW_CRAFT:String = 'previewCraft';
		public static const CRAFT_ABILITY:String = 'craftAbility';
		public static const DESTROY_ABILITY:String = 'destroyAbility';
		public static const CRAFT_READY:String = '_craftAbReady';
		public static const INCREMENT_ABILITY:String = 'incrementAbility';
		public static const DISABLE_ABILITY:String = 'disableAbility';
		public static const ENABLE_ABILITY:String = 'enableAbility';
		public static const PREVIEW_ABILITY:String = 'previewAbility';
		public static const STOP_PREVIEW_ABILITY:String = 'stopPreviewAbility';
		public static const ACTIVATE_SPELL_ABILITY:String = 'activateSpellAbility';
		public static const ACTIVATE_SPELL_TO_TARGET_ABILITY:String = 'activateSpellToTargetAbility';
		public static const TARGET_FOR_ABILITY_INIT:String = 'targetForAbilityInit';
		

		
		public function AbilityEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
			
		}
		
	}

}