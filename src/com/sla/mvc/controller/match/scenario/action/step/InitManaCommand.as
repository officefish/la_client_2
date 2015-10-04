package com.sla.mvc.controller.match.scenario.action.step 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.Field;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitManaCommand extends StarlingCommand 
	{
		[Inject]
		public var field:Field;
		
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var matchModel:MatchModel;
		
		override public function execute():void 
		{
			matchModel.mana = event.data.mana;
			if (event.data.client) {
				field.setPlayerMana(event.data.mana, event.data.overload);
				field.setOpponentMana(0, 0);
			} else {
				field.setOpponentMana(event.data.mana, event.data.overload);
				field.setPlayerMana(0, 0);
			}
			dispatch(new ScenarioEvent (ScenarioEvent.ACTION));
		}	
	}

}