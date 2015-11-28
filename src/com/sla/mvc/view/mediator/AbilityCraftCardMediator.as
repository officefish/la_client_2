package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.la.event.AchieveEvent;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.ability.AbilityCraftCard;
	import org.robotlegs.mvcs.StarlingMediator;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityCraftCardMediator extends StarlingMediator 
	{
		
		override public function onRegister():void 
		{
			addViewListener(TouchEvent.TOUCH, onTouch);  
		}
		
		private function onTouch(event:TouchEvent) :void {
			var card:AbilityCraftCard = this.viewComponent as AbilityCraftCard;
			/*
			if (card.isBlocked) {
				return;
			}
			*/
			
			var touch:Touch = event.getTouch(event.currentTarget as DisplayObject, null, -1);
			if(!touch)  
			{
				return; 
			}
			if(touch.phase == TouchPhase.BEGAN) 
			{
				preview();
			}
			
		}
		
		private function preview () :void {
			//MonsterDebugger.log ('preview');
			dispatch(new AbilityEvent(AbilityEvent.PREVIEW_CRAFT, {card:this.viewComponent}));
		}
		
		
		
	}

}