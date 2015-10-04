package com.sla.mvc.controller.match.scenario.action.minion 
{
	import com.sla.event.ScenarioEvent;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.mvc.view.field.Field;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class GlowMinionsCommand extends StarlingCommand 
	{
		[Inject]
		public var field:Field;
		
		[Inject]
		public var event:ScenarioEvent;
		
		
		override public function execute():void 
		{
			if (event.data.client) {
				field.glowMinions();
			} 
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
			
		}		
	}

}