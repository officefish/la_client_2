package com.sla.mvc.controller.match.scenario.action.minion 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.field.minion.IMinion;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SeveralMinionsHealthCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('SeveralMinionHealthCommand::execute()');
			var targets:Array = event.data.targets;
			var index:int;
			var attachment:int;
			var minion:IMinion 
			var client:Boolean = event.data.client; 
			for (var i:int = 0; i < targets.length; i ++) {
				index = targets[i].index;
				attachment = targets[i].attachment;
				minion = this.initMinionByAttachment(index, attachment, client);
				minion.setHealth(targets[i].health);
			}
			
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}		
	}

}