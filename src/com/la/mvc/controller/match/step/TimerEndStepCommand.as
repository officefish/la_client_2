package com.la.mvc.controller.match.step 
{
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class TimerEndStepCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console;
				
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		override public function execute():void 
		{
			/*
			if (
			rootModel.currentState ==  GameState.PLAYER_STEP ||
			rootModel.currentState == GameState.PLAYER_STEP_ACTION ||
			rootModel.currentState == GameState.PLAYER_STEP_PREVIEW
			) {
			*/
				console.debug ('TimerEndStepCommand::execute')
				console.debug (rootModel.currentState.value.toString())
				
				scene.runStepTimer ();
			//}
			
		}		
	}

}