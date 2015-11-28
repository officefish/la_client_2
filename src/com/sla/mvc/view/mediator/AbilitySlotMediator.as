package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.ability.AbilitySlot;
	import org.robotlegs.mvcs.Mediator;
	import org.robotlegs.mvcs.StarlingMediator;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilitySlotMediator extends StarlingMediator
	{
		override public function onRegister():void 
		{
			addViewListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(event:TouchEvent) :void {
			var touch:Touch = event.getTouch(event.currentTarget as DisplayObject, null, -1);
			if(!touch)  
			{
				return; 
			}
			if(touch.phase == TouchPhase.BEGAN) 
			{
				removeSlot();
			}
			
		}
		
		private function removeSlot () :void {
			dispatch(new AbilityEvent(AbilityEvent.REMOVE_ABILITY, {abilityId:(this.viewComponent as AbilitySlot).abilityId}))
		}
	}

}