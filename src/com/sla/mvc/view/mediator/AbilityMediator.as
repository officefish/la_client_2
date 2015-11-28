package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.la.mvc.view.collection.NewDeckButton;
	import com.sla.event.AbilityEvent;
	import com.sla.event.starling.StarlingCollectionEvent;
	import com.sla.mvc.model.HeroModel;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityMediator extends StarlingMediator 
	{
		[Inject]
		public var model:HeroModel; 
		
		override public function onRegister():void 
		{
			addViewListener(StarlingCollectionEvent.HERO_DELECT, onHeroSelect);
			addViewListener(StarlingCollectionEvent.SAVE_ABILITIES, onSaveAbilities);
			addViewListener(StarlingCollectionEvent.CRAFT_ABILITIES, onCraftAbilities);
			addViewListener(StarlingCollectionEvent.CRAFT_ABILITIES_READY, onCraftAbilitiesReady);
		}
		
		private function onHeroSelect (event:StarlingCollectionEvent) :void {
			dispatch(new AbilityEvent(AbilityEvent.HERO_SELECT, event.data ));
		}
		
		private function onSaveAbilities (event:StarlingCollectionEvent) :void {
			dispatch(new AbilityEvent(AbilityEvent.SAVE_ABILITIES, event.data ));
		}
		
		private function onCraftAbilities (event:StarlingCollectionEvent) :void {
			dispatch(new AbilityEvent(AbilityEvent.CRAFT));
		}
		
		private function onCraftAbilitiesReady (event:StarlingCollectionEvent) :void {
			dispatch(new AbilityEvent(AbilityEvent.CRAFT_READY, {heroId:model.heroId}));
		}
		
	}

}