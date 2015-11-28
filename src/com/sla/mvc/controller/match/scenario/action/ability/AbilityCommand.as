package com.sla.mvc.controller.match.scenario.action.ability 
{
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.FieldAbilitySlot;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityCommand extends StarlingCommand 
	{
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var field:Field;
		
		public function getAbility (position:int, client:Boolean) :FieldAbilitySlot {
			var ability:FieldAbilitySlot = field.getAbilitySlot(position, client);
			return ability;
		}
		
		
		
	}

}