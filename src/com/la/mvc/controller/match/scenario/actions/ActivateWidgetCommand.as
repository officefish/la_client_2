package com.la.mvc.controller.match.scenario.actions 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.event.TokenEvent;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.token.Token;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ActivateWidgetCommand extends Command 
	{
		
		[Inject] 
		public var event:SceneEvent; 
		
		override public function execute():void 
		{
			var token:Token = event.data.targetToken as Token;
			if (token.hasWidget) {
				token.addEventListener(TokenEvent.WIDGET_ACTIVATE_COMPLETE, onActivationComplete);
				token.activateWidget();
			} else {
				dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
			}
		}
		
		private function onActivationComplete (event:TokenEvent) :void {
			event.target.removeEventListener(TokenEvent.WIDGET_ACTIVATE_COMPLETE, onActivationComplete);
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));  
		}
		
	}

}