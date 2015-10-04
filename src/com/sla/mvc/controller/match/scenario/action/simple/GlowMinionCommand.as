package com.sla.mvc.controller.match.scenario.action.simple 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.controller.match.scenario.ScenarioActionCommand;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.minion.IMinion;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class GlowMinionCommand extends MinionActionCommand 
	{
		
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var matchModel:MatchModel; 
		
		override public function execute():void 
		{
			var client:Boolean = event.data.client;
			var minion:IMinion = getTarget(event.data.index, event.data.attachment, client); 
			if (event.data.client) {
				if (minion.canAttack) {
					minion.block = false;
					minion.glow();
				}
				if (minion.hasActiveAptitude && minion.activeManacost <= matchModel.mana) {
					minion.block = false;
					minion.glow();
				}
			} 
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
			
		}		
		
	}

}