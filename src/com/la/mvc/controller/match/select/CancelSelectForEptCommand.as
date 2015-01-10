package com.la.mvc.controller.match.select 
{
	import com.la.mvc.service.MatchService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CancelSelectForEptCommand extends Command 
	{
		
		[Inject]
		public var service:MatchService;
				
		override public function execute():void 
		{
			service.sendMessage ('cancel_select', {});	
		}
		
	}

}