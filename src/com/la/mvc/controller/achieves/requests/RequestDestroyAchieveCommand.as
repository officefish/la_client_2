package com.la.mvc.controller.achieves.requests {
	import com.la.event.AchieveEvent;
	import com.la.mvc.model.HeroModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.ApiService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestDestroyAchieveCommand extends Command 
	{
		[Inject]
		public var event:AchieveEvent; 
		
		[Inject]
		public var service:ApiService; 
		
		[Inject (name='heroModel')]
		public var model:HeroModel; 
				
		[Inject (name='rootModel')]
		public var rootModel:RootModel;  
		
		override public function execute():void 
		{
			service.destroyAchieve (rootModel.userId, model.heroId, event.getData()['achieveId']);
		}	
	}

}