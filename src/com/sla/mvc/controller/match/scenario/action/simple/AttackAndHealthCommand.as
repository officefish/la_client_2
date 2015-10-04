package com.sla.mvc.controller.match.scenario.action.simple 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.field.minion.IMinion;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AttackAndHealthCommand extends MinionActionCommand 
	{
		[Inject] 
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			var client:Boolean = event.data.client;
			var target:IMinion = getTarget(event.data.index, event.data.attachment, client); 
			var power:int = event.data.power;
			target.setMaxHealth (target.getMaxHealth() + power)
			target.setHealth (target.getHealth() + power);
			target.setAttack(target.getAttack() + power)
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}	
		
	}

}