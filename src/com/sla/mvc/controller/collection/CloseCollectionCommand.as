package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.IntroEvent;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CloseCollectionCommand extends StarlingCommand 
	{
		[Inject]
		public var stateModel:StateModel; 
		
		override public function execute():void 
		{
			MonsterDebugger.log ('CloseCollectionCommand::execute()');
			stateModel.state = GameState.INTRO;
			dispatch (new IntroEvent(IntroEvent.STARTUP)); 
		}		
	}

}