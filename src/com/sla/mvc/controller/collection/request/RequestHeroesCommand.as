package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestHeroesCommand extends StarlingCommand 
	{
		[Inject]
		public var service:ApiService; 
		
		[Inject] 
		public var rootModel:RootModel; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('RequestHeroesCommand::execute()');
			service.requestHeroes (rootModel.userId);
		}				
	}

}