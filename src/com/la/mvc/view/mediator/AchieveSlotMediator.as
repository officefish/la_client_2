package com.la.mvc.view.mediator 
{
	import com.la.event.CardEvent;
	import com.la.mvc.view.achieves.AchieveSlot;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveSlotMediator extends Mediator 
	{
		[Inject]
		public var slot:AchieveSlot;
		
		override public function onRegister():void 
		{
			eventMap.mapListener(slot, MouseEvent.MOUSE_DOWN, onMouseDown); 
			eventMap.mapListener(slot, MouseEvent.MOUSE_OVER, onMouseOver);
			eventMap.mapListener(slot, MouseEvent.MOUSE_OUT, onMouseOut);

		}		
		
		private function onMouseDown (event:MouseEvent) :void {
			dispatch(new CardEvent(CardEvent.DRAG_ACHIEVE_SLOT, {'slot':slot})) 
		}
		private function onMouseOver (event:MouseEvent) :void {
			Mouse.cursor = MouseCursor.HAND; 
			
		}
		private function onMouseOut (event:MouseEvent) :void {
			Mouse.cursor = MouseCursor.AUTO; 
		}
	}

}