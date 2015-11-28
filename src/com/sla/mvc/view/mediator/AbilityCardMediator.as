package com.sla.mvc.view.mediator 
{
	import com.la.mvc.view.collection.NewDeckButton;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.ability.AbilityCard;
	import org.robotlegs.mvcs.StarlingMediator;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityCardMediator extends StarlingMediator 
	{
		
		override public function onRegister():void 
		{
			addViewListener(TouchEvent.TOUCH, onTouch); 
		}
		
		private function onTouch(event:TouchEvent) :void {
			var card:AbilityCard = this.viewComponent as AbilityCard;
			if (card.isBlocked) {
				return;
			}
			
			var touch:Touch = event.getTouch(event.currentTarget as DisplayObject, null, -1);
			if(!touch)  
			{
				return; 
			}
			if(touch.phase == TouchPhase.BEGAN) 
			{
				addSlot();
			}
			
		}
		
		private function addSlot () :void { 
			dispatch(new AbilityEvent(AbilityEvent.ADD_ABILITY, {abilityId:(this.viewComponent as AbilityCard).abilityId}))
		}
		
	}

}