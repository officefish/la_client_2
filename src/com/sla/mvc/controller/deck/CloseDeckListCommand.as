package com.sla.mvc.controller.deck 
{
	import com.sla.event.IntroEvent;
	import com.sla.state.GameState;
	import com.sla.mvc.model.StateModel;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CloseDeckListCommand extends StarlingCommand 
	{
		[Inject (name="stateModel")]
		public var stateModel:StateModel; 
		
		override public function execute():void 
		{
			stateModel.state = GameState.INTRO;
			dispatch (new IntroEvent(IntroEvent.STARTUP));
		}
	}

}