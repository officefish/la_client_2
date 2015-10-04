package com.sla.mvc.controller.match.preflop.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestPreflopInitCommand extends StarlingCommand 
	{
		[Inject]
		public var service:MatchService; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('RequestPreflopInitCommand::execute()');
			service.sendMessage('end_change_preflop', {});
		}		
	}

}