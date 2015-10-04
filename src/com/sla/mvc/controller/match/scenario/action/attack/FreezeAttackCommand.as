package com.sla.mvc.controller.match.scenario.action.attack 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.field.minion.IMinion;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FreezeAttackCommand extends PassiveAttackCommand 
	{
		override protected function onComplete () :void {
			var client:Boolean = event.data.client; 
			var target:IMinion = getTarget(event.data.targetIndex, event.data.targetAttachment, client);
			target.activateFreeze();
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
		
	}

}