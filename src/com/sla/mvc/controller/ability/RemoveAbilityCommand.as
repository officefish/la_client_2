package com.sla.mvc.controller.ability 
{
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import org.robotlegs.mvcs.StarlingCommand;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RemoveAbilityCommand extends StarlingCommand
	{
		
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var browser:AbilityBrowser;  
		
		override public function execute():void 
		{
			var abilityId:int = event.data.abilityId;
			browser.removeAbility(abilityId);
		}
	}

}