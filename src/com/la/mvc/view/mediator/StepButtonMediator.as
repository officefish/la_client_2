package com.la.mvc.view.mediator 
{
	import com.la.event.FieldEvent;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.StepButton;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StepButtonMediator extends Mediator 
	{
		
		[Inject]
		public var button:StepButton;
		
		[Inject (name='appConsole')]
		public var console:Console;  
		
		override public function onRegister():void 
		{
			eventMap.mapListener (button, FieldEvent.END_STEP, endStep);
		}
		
		private function endStep (event:FieldEvent) :void {
			//console.debug ('endStep', event.target);
			dispatch (event);
		}
		
	}

}