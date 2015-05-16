package com.la.mvc.controller.achieves 
{
	import com.la.event.HeroesEvent;
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
		
		override public function execute():void 
		{
			//trace ('ResponseEditAchievesCommand::execute');
			//trace (event.getData()['hero_id']);
			service.editAchieves (1, event.getData()['hero_id'])
		}				
		
		
	}

}