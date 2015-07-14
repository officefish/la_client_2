package com.la.mvc.view.mediator 
{
	import com.la.event.FieldEvent;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.FieldAchieveSlot;
	import com.la.state.GameState;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldAchieveSlotMediator extends Mediator 
	{
		[Inject]
		public var slot:FieldAchieveSlot;
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
		
		override public function onRegister():void 
		{
			eventMap.mapListener(slot, MouseEvent.MOUSE_OVER, onMouseOver);
			eventMap.mapListener(slot, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(slot, MouseEvent.MOUSE_DOWN, onMouseDown);
		}		
		
		private function onMouseOver (event:MouseEvent) :void {
			dispatch (new FieldEvent(FieldEvent.ACHIEVE_PREVIEW, { slot:slot } ));
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			if (slot.getMirror().parent) {
				slot.getMirror().parent.removeChild(slot.getMirror());
			}
		}
		
		private function onMouseDown (event:MouseEvent) :void {
			if (slot.getMirror().parent) {
				slot.getMirror().parent.removeChild(slot.getMirror());
			}
			
			if (rootModel.currentState != GameState.PLAYER_STEP) {
				return;
			}
			
			if (!slot.isActive()) {
				return;
			}
			
			if (slot.getType() == 0) {
				// dispatch activate spell
				dispatch (new FieldEvent (FieldEvent.ACTIVATE_SPELL_ACHIEVE, { 'position':slot.getPosition() } ));
			} else if (slot.getType() == 1) {
				// displatch activate spell to target 
				dispatch(new FieldEvent (FieldEvent.ACTIVATE_SPELL_TO_TARGET_ACHIEVE, {'slot':slot}));
			}
		}
	}

}