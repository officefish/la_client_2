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
			
			if (minion == null) {
				dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
				return;
			}
			
			var blockFlag:Boolean = true;
			
			if (event.data.client) {
				if (event.data.canAttack) {
					minion.block = false;
					minion.glow();
					blockFlag = false;
				}
				if (minion.hasActiveAptitude && minion.activeManacost <= matchModel.mana && minion.activeBlock == false) {
					minion.block = false;
					minion.glow();
					blockFlag = false;
				}
				if (blockFlag) {
					minion.block = true;
					minion.stopGlow();
				}
			} 
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
			
		}		
		
	}

}