package com.sla.mvc.controller.match.scenario.action.attack 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AttackAvailableCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			var minions:Array = event.data.minions;
			field.markMinionsAsAttackAvailable(minions);
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}		
	}

}