package com.la.mvc.controller.achieves.requests {
	import com.la.mvc.service.MatchService;
	import org.robotlegs.mvcs.Command;
	import com.la.event.FieldEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestActivateAchieveTotargetCommand extends Command 
	{
		
		[Inject]
		public var event:FieldEvent;
		
		[Inject]
		public var service:MatchService; 
		
		
		override public function execute():void 
		{
			service.sendMessage ('activate_achieve_to_target', event.getData());
		}	
	}

}