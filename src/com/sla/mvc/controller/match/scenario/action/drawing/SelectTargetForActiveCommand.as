package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.event.SceneEvent;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectTargetForActiveCommand extends SelectTargetForAptitudeCommand 
	{
		
		override protected function selectMinion(data:Object):void 
		{
			var attachment:int = 0;
			if (data.player == false) {
				attachment = 1;
			}
			var serviceData:Object = { };
			serviceData['attachment'] = attachment;
			serviceData['index'] = data.index; 
			dispatch (new SceneEvent(SceneEvent.TARGET_FOR_ACTIVE_SELLECTED, serviceData));
			
		}
		
		override protected function cancelSelect():void 
		{
			var actionData:Object = { };
			actionData.client = true; 
			dispatch(new ScenarioEvent(ScenarioEvent.GLOW_MINIONS, actionData));
		}
		
	}

}