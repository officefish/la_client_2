package com.sla.mvc.controller.decklist.request {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestDeckListCommand extends StarlingCommand 
	{
		[Inject]
		public var service:ApiService; 
		
		override public function execute():void 
		{
			MonsterDebugger.log("RequestDeckListCommand::execute()");
			service.requestDeckList();
		}		
	}

}