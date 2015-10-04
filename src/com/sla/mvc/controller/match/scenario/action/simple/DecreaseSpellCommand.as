package com.sla.mvc.controller.match.scenario.action.simple 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.hand.PlayerHand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DecreaseSpellCommand extends MinionActionCommand 
	{
		
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var model:MatchModel; 
		
		[Inject]
		public var hand:PlayerHand;
		
		override public function execute():void  
		{
			MonsterDebugger.log ('DecreaseSpellCommand::execute()'); 
			var client:Boolean = event.data.client; 
			var target:IMinion = getTarget(event.data.index, event.data.attachment, client); 
			if (target) {
				target.deactivateSpellUp();
			}
					
			if (event.data.spellClient) {
				model.setSpellMixin(event.data.spellMixin);
				hand.setSpellMixin(model.getSpellMixin());
			}
			
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}	
		
	}

}