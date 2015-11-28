package com.sla.mvc.controller.match.scenario.action.ability 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.FieldAbilitySlot;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DisableAbilityCommand extends AbilityCommand 
	{
		
		override public function execute():void 
		{
			var position:int = event.data.position;
			var client:Boolean = event.data.client;
			var ability:FieldAbilitySlot = getAbility(position, client); 
			ability.disable();
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
		
	}

}