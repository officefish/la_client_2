package com.la.mvc.controller.match.scenario 
{
	import com.la.event.MatchServiceEvent;
	import com.la.event.ScenarioEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.debug.Console;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioCommand extends Command 
	{
		
		[Inject (name='appConsole')]
		public var console:Console;
		
		[Inject]
		public var event:MatchServiceEvent;
		
		[Inject (name = 'matchModel')]
		public var matchModel:MatchModel;
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel;
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		
		override public function execute():void 
		{
			if (matchModel.scenarioLength) {
				matchModel.concatScenario (event.getData().scenario)
			} else {
				matchModel.setScenario (event.getData().scenario);
			}
			
			
			playerDeck.block();
			
			if (rootModel.currentState == GameState.OPPONENT_STEP) {
				rootModel.currentState = GameState.OPPONENT_STEP_ACTION;
			} else if (rootModel.currentState == GameState.PLAYER_STEP) {
				rootModel.currentState = GameState.PLAYER_STEP_ACTION;
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
			
		}
		
	}

}