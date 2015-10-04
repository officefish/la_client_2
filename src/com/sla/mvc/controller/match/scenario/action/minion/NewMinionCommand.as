package com.sla.mvc.controller.match.scenario.action.minion 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.Field;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class NewMinionCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var field:Field; 
		
		override public function execute():void 
		{
			
			MonsterDebugger.log ('NewMinionCommand::execute()');
			var playerFlag:Boolean = true;
			if (event.data.client) {
				if (event.data.attachment) {
					playerFlag = true;
				} else {
					playerFlag = false;
				}
			} else {
				if (event.data.attachment) {
					playerFlag = false;
				} else {
					playerFlag = true;
				}
			}
			
			field.addMinion(event.data.cardData, event.data.index, playerFlag);
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}	
	}

}