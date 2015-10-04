package com.sla.mvc.controller.match.scenario.action.drawing.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.service.MatchService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestTargetForAttackInitCommand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var service:MatchService;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestTargetForAttackInitCommand::execute()');
			service.sendMessage('classic_attack', event.data);
		}	
	}

}