package com.la.mvc.view.mediator 
{
	import com.la.event.CollectionEvent;
	import com.la.mvc.view.collection.CraftWidget;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftMediator extends Mediator 
	{
		[Inject (namespace = 'craftWidget')]
		public var widget:CraftWidget;
		
		override public function onRegister():void 
		{
			eventMap.mapListener(widget, CollectionEvent.CRAFT_CARD, dispatcher);
			eventMap.mapListener(widget, CollectionEvent.DESTROY_CARD, dispatcher);
		}
		
		private function dispatcher (event:CollectionEvent) :void {
			dispatch (event);
		}
	}

}