package com.la.mvc.view.mediator 
{
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftWidgetMediator extends StarlingMediator 
	{
		
		override public function onRegister():void {
			eventMap.mapListener(card, CardEvent.COLLECTION_CLICK, listener); 
			eventMap.mapListener(card, MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
	}

}