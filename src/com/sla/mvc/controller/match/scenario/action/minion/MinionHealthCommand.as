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
	public class MinionHealthCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('MinionHealthCommand::execute()');
			var index:int = event.data.index;
			var attachment:int = event.data.attachment;
			var client:Boolean = event.data.client; 
			var minion:IMinion = this.initMinionByAttachment(index, attachment, client);
			if (event.data.maxHealth) {
				minion.setMaxHealth(event.data.maxHalth);
			}
			minion.setHealth(event.data.health);
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			//super.execute();
		}		
	}

}