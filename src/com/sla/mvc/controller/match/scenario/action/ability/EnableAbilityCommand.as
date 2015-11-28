package com.sla.mvc.controller.match.scenario.action.ability 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.FieldAbilitySlot;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EnableAbilityCommand extends AbilityCommand
	{
		
		override public function execute():void 
		{
			var position:int = event.data.position;
			var client:Boolean = event.data.client;
			var ability:FieldAbilitySlot = getAbility(position, client); 
			ability.enable();
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
		
	}

}