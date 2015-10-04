package com.sla.mvc.controller.match.scenario 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.MatchServiceEvent;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioCommand extends StarlingCommand 
	{
		[Inject]
		public var matchModel:MatchModel; 
		
		[Inject]
		public var event:MatchServiceEvent;
		
		[Inject]
		public var stateModel:StateModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log('ScenarioCommand::execute()')
			if (matchModel.scenarioLength) {
				matchModel.concatScenario (event.data.scenario)
			} else {
				matchModel.setScenario (event.data.scenario);
			}
			
			matchModel.block = true;
			
			if (stateModel.state == GameState.OPPONENT_STEP) { 
				stateModel.state = GameState.OPPONENT_STEP_ACTION;
			} else if (stateModel.state == GameState.PLAYER_STEP) {
				stateModel.state = GameState.PLAYER_STEP_ACTION;
			}
			
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION)); 
				
		}		
	}

}