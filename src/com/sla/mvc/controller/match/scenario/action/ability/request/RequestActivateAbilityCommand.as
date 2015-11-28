package com.sla.mvc.controller.match.scenario.action.ability.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestActivateAbilityCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var service:MatchService; 
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestActivateAbilityCommand::execute()');
			var position:int = event.data.position;
			service.sendMessage ('activate_achieve', {position:position});
		}
		
	}

}