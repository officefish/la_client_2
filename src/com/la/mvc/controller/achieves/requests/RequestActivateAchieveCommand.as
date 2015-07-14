package com.la.mvc.controller.achieves.requests {
	import com.la.event.FieldEvent;
	import com.la.mvc.service.MatchService;
	import com.la.mvc.view.debug.Console;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestActivateAchieveCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject]
		public var event:FieldEvent;
		
		[Inject]
		public var service:MatchService; 
		
		override public function execute():void 
		{
			console.debug ('RequestActivateAchieveCommand::execute')
			//super.execute();
			var position:int = event.getData().position;
			service.sendMessage ('activate_achieve', {position:position});
		}		
	}

}