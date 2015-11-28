package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.event.CollectionEvent;
	import com.sla.event.starling.StarlingCraftButtonEvent;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftWidgetMediator extends StarlingMediator 
	{
		
		[Inject]
		public var stateModel:StateModel;
		
		override public function onRegister():void 
		{
			addViewListener(StarlingCraftButtonEvent.CRAFT, onCraft); 
			addViewListener(StarlingCraftButtonEvent.DESTROY, onDestroy);
		}
		
		private function onCraft (event:StarlingCraftButtonEvent) :void {
			if (stateModel.state == GameState.CRAFT_ABILITY) {
				MonsterDebugger.log ('craftAbility');
				dispatch(new AbilityEvent(AbilityEvent.CRAFT_ABILITY))
			} else {
				dispatch(new CollectionEvent(CollectionEvent.CRAFT_CARD));
			}
			
		}
		
		private function onDestroy (event:StarlingCraftButtonEvent) :void {
			if (stateModel.state == GameState.CRAFT_ABILITY) {
				dispatch(new AbilityEvent(AbilityEvent.DESTROY_ABILITY));
			} else {
				dispatch(new CollectionEvent(CollectionEvent.DUST_CARD));
			}
			
		}
		
	}

}