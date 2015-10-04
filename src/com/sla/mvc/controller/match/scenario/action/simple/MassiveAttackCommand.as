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
	public class MassiveAttackCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent; 
		
		override public function execute():void 
		{
			
			MonsterDebugger.log ('MassiveAttackCommand::execute()');
			var client:Boolean = event.data.client;
			
			var targets:Array = event.data.targets;
			var targetData:Object;
			var minion:IMinion;  
			for (var i:int = 0; i < targets.length; i ++) {
				targetData = targets[i];
				minion = this.getTarget(targetData.index, targetData.attachment, client);
				minion.setHealth(targetData.health);
			}
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		} 			
	}

}