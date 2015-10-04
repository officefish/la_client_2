package com.sla.mvc.controller.match.scenario.exeption 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ExceptionCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('ExceptionCommand::execute()');
			if (event.data.client) {
				scene.warning (ScenarioExeption.getWarning(event.data.exception));
			} 
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}		
	}

}