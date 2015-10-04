package com.sla.mvc.controller.match.scenario.action.step 
{
	import com.sla.mvc.model.StateModel;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.state.GameState;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StepCommand extends StarlingCommand 
	{
		[Inject]
		public var field:Field;
		
		[Inject]
		public var stateModel:StateModel; 
		
		[Inject]
		public var event:ScenarioEvent;
		
				
		
		override public function execute():void 
		{
			if (event.data.client) {
				stateModel.state = GameState.PLAYER_STEP;
				field.enableStepButton ();
			} else {
				stateModel.state = GameState.OPPONENT_STEP;
				//field.clearOpponentMana();
			}
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}		
	}

}