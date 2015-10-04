package com.sla.mvc.controller.intro 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionSelectCommand extends StarlingCommand 
	{
		
		[Inject]
		public var stateModel:StateModel; 
		
		override public function execute():void 
		{
			MonsterDebugger.log ("CollectionSelectCommand::execute()");
			stateModel.state = GameState.COLLECTION; 
		}		
		
	}

}