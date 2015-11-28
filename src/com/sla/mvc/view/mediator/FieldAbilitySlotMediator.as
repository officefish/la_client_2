package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.field.FieldAbilitySlot;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingMediator;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldAbilitySlotMediator extends StarlingMediator 
	{
		[Inject]
		public var stateModel:StateModel;
		
		override public function onRegister():void 
		{
			addViewListener(TouchEvent.TOUCH, onTouch); 
		}
		
		private function onTouch(event:TouchEvent) :void {
			var view:DisplayObject = this.getViewComponent() as DisplayObject; 
			var slot:FieldAbilitySlot = view as FieldAbilitySlot;
			if (!slot) {
				return;
			}
			if (event.getTouch(view, TouchPhase.HOVER)) { 
				if (!slot.showMirror) {
					dispatch(new AbilityEvent(AbilityEvent.PREVIEW_ABILITY, { slot:slot } ));
					slot.showMirror = true;
				}
			} else {
				slot.showMirror = false;
				dispatch(new AbilityEvent(AbilityEvent.STOP_PREVIEW_ABILITY, { slot:slot } ));
			}
			
			var touch:Touch = event.getTouch(view, TouchPhase.BEGAN);
			if (touch) {
				if (slot.getMirror().parent) {
					slot.getMirror().parent.removeChild(slot.getMirror());
				}
				
				if (slot.isEnemy) {
					return;
				}
				
				if (stateModel.state != GameState.PLAYER_STEP) {
					return;
				}
				
				if (!slot.isActive) {
					return;
				}
				
				if (slot.getType() == 0) {
					dispatch (new AbilityEvent (AbilityEvent.ACTIVATE_SPELL_ABILITY, { 'position':slot.getPosition() } ));
				} else if (slot.getType() == 1) {
					dispatch(new AbilityEvent (AbilityEvent.ACTIVATE_SPELL_TO_TARGET_ABILITY, {'slot':slot}));
				}				
			}
		}
		
	}

}