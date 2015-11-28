package com.sla.mvc.controller.match.scenario.action.ability 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.FieldAbilitySlot;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class IncrementAbilityCommand extends AbilityCommand
	{
		
		override public function execute():void 
		{
			MonsterDebugger.log ('IncrementAbilityCommand::execute()');
			
			var position:int = event.data.position;
			var client:Boolean = event.data.client;
			var increment:int = event.data.increment;
			var enable:Boolean = event.data.enable;
			
			var ability:FieldAbilitySlot = getAbility(position, client);
			ability.increment(increment);
			if (enable) {
				ability.enable();
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
		
		
		
	}

}