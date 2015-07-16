package com.sla.mvc.controller.state 
{
	import com.sla.state.GameState;
	import com.sla.mvc.model.StateModel;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ChangeStateCommand extends StarlingCommand 
	{
		[Inject (name="stateModel")]
		public var stateModel:StateModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ("ChangeStateCommand::execute()");
			while (contextView.numChildren) contextView.removeChildAt (0);
			switch (stateModel.state) {
				case GameState.DECK_LIST: 
				{
					MonsterDebugger.log ('change state to decklist');
					break;
				}
			}
			
		}		
	}

}