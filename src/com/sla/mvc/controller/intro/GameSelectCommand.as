package com.sla.mvc.controller.intro 
{
	import com.sla.state.GameState;
	import com.sla.mvc.model.StateModel;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class GameSelectCommand extends StarlingCommand 
	{
		[Inject]
		public var stateModel:StateModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ("GameSelectCommand::execute()");
			stateModel.state = GameState.DECK_LIST;
		}		
	}

}