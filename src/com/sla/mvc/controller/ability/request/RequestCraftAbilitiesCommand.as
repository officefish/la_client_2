package com.sla.mvc.controller.ability.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCraftAbilitiesCommand extends StarlingCommand 
	{
		
		[Inject]
		public var service:ApiService;  
		
		[Inject]
		public var model:HeroModel; 
		
		[Inject] 
		public var rootModel:RootModel;  
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestCraftAbilities::execute()');
			service.requestCraftAbilities (rootModel.userId, model.heroId);
		}
		
	}

}