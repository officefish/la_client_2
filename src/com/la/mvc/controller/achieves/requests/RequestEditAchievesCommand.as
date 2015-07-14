package com.la.mvc.controller.achieves.requests {
	import com.la.event.HeroesEvent;
	import com.la.mvc.model.HeroModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.ApiService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestEditAchievesCommand extends Command 
	{
		
		[Inject]
		public var service:ApiService; 
		
		[Inject]
		public var event:HeroesEvent;
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel;  
		
		
		
		override public function execute():void 
		{
			service.editAchieves (rootModel.userId, event.getData()['hero_id'])
		}				
		
		
	}

}