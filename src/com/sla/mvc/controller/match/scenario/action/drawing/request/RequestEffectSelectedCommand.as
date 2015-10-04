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
	public class RequestEffectSelectedCommand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject] 
		public var service:MatchService; 
		
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestEffectSelectedCommand::execute()');
			service.sendMessage ('effect_selected', {index:event.data.index});	
		}		
	}

}