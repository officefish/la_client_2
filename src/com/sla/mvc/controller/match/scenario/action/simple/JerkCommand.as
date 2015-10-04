package com.sla.mvc.controller.match.scenario.action.simple 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.field.minion.IMinion;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class JerkCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			
			var client:Boolean = event.data.client;
			if (!client) {
				dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
				return;
			}
			var targets:Array = event.data.targets;
			var targetData:Object;
			var minion:IMinion;
			for (var i:int = 0; i < targets.length; i ++) {
				targetData = targets[i];
				minion = this.getTarget(targetData.index, targetData.attachment, client);
				minion.canAttack = true;
				minion.block = false;
				minion.glow();
			}
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		} 	
	}

}