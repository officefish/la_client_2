package com.la.mvc.view.mediator 
{
	import com.la.event.CardEvent;
	import com.la.mvc.view.card.AchieveCard;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveCardMediator extends Mediator 
	{
		[Inject]
		public var card:AchieveCard;
		
		
		override public function onRegister():void 
		{
			eventMap.mapListener(card, MouseEvent.MOUSE_DOWN, onMouseDown);
			eventMap.mapListener(card, MouseEvent.MOUSE_OVER, onMouseOver);
			eventMap.mapListener(card, MouseEvent.MOUSE_OUT, onMouseOut);

		}	
		
		private function onMouseDown(event:MouseEvent) :void {
			if (card.isBlocked) {
				return;
			}
			dispatch(new CardEvent(CardEvent.DRAG_ACHIEVE_CARD, {'card':card}))
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			if (card.isBlocked) {
				return;
			}
			Mouse.cursor = MouseCursor.HAND; 
			
		}
		private function onMouseOut (event:MouseEvent) :void {
			if (card.isBlocked) {
				return;
			}
			Mouse.cursor = MouseCursor.AUTO; 
		}
	}

}