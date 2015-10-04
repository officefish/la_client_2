package com.sla.mvc.controller.match.preflop.request {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestPreflopClickCommand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var service:MatchService;
		
		override public function execute():void 
		{
			MonsterDebugger.log('RequestPreflopClickCommand::execute()');
			service.sendMessage('preflop_click', event.data);
		}
	}

}