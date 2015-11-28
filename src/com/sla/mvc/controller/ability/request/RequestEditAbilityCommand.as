package com.sla.mvc.controller.ability.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestEditAbilityCommand extends StarlingCommand 
	{
		
		[Inject]
		public var service:ApiService; 
		
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var rootModel:RootModel; 
		
		
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestEditAbilityCommand');
			MonsterDebugger.log (event.data);
			service.editAbilities (rootModel.userId, event.data.heroId);
		}				
		
	}

}