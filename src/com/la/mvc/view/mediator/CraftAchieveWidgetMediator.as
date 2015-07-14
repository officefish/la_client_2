package com.la.mvc.view.mediator 
{
	import com.la.event.AchieveEvent;
	import com.la.mvc.view.achieves.CraftAchieveWidget;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftAchieveWidgetMediator extends Mediator 
	{
		
		[Inject (namespace = 'craftAchieveWidget')]
		public var widget:CraftAchieveWidget;
		
		override public function onRegister():void 
		{
			eventMap.mapListener(widget, AchieveEvent.CRAFT, dispatcher);
			eventMap.mapListener(widget, AchieveEvent.DESTROY, dispatcher);
		}
		
		private function dispatcher (event:AchieveEvent) :void {
			dispatch (event);
		}
		
	}

}