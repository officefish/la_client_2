package com.sla.mvc.controller.ability 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AddAbilityCommand extends StarlingCommand 
	{
		[Inject]
		public var event:AbilityEvent;
		
		[Inject] 
		public var browser:AbilityBrowser;  
		
		
		override public function execute():void 
		{
			MonsterDebugger.log('AddAbilityCommand::execute()');
			browser.addAbility(event.data.abilityId);
		}
		
	}

}