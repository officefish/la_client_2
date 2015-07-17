package com.sla.mvc.view.mediator 
{
	import com.sla.event.DeckEvent;
	import com.sla.event.starling.StarlingDeckListEvent;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingDeckListEvent.CLOSE, onClose);
		}
		
		private function onClose (event:StarlingDeckListEvent) :void {
			dispatch(new DeckEvent(DeckEvent.CLOSE));
		}
	}

}