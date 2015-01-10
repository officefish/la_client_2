package com.la.mvc.controller.match.select 
{
	import com.la.event.SceneEvent;
	import com.la.mvc.service.MatchService;
	import com.la.mvc.view.debug.Console;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectForEptitudeInitCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='appConsole')]
		public var console:Console;
		
		[Inject]
		public var service:MatchService;
						
		
		override public function execute():void 
		{
			service.sendMessage ('init_select', event.data);
			//console.debug('SelectEptitudeForServiceData::execute ' + event.data.serviceData);
		}	
	}

}