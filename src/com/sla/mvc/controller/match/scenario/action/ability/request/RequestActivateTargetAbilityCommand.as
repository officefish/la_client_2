package com.sla.mvc.controller.match.scenario.action.ability.request 
{
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestActivateTargetAbilityCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var service:MatchService; 
		
		
		override public function execute():void 
		{
			service.sendMessage ('activate_achieve_to_target', event.data);
		}
		
	}

}