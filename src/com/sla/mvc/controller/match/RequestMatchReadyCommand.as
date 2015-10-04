package com.sla.mvc.controller.match 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestMatchReadyCommand extends StarlingCommand 
	{
		[Inject]
		public var service:MatchService; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('RequestMatchReadyCommand::execute()');
			service.sendMessage('ready', {});
			//super.execute();
		}		
	}

}