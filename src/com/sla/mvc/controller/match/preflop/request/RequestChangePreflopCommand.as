package com.sla.mvc.controller.match.preflop.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestChangePreflopCommand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent; 

		[Inject]
		public var service:MatchService;
		
		override public function execute():void 
		{
			MonsterDebugger.log('RequestChangePreflopCommand::execute()');
			var replacement:Array = event.data.replacement;
			service.sendMessage('change_preflop', {'preflop':replacement});
		}		
	}

}