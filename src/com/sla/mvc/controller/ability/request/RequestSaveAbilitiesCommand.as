package com.sla.mvc.controller.ability.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.event.AbilityEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestSaveAbilitiesCommand extends StarlingCommand 
	{
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var service:ApiService;  
		
		[Inject]
		public var rootModel:RootModel; 
		
		[Inject]
		public var model:HeroModel;  
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestSaveAbilitiesCommand::execute()');
			service.requestSaveAbilities (rootModel.userId, model.heroId, event.data.setup);
			
		}
	}

}