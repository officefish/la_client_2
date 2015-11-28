package com.sla.mvc.controller.ability 
{
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilitySelectCommand extends StarlingCommand 
	{
		
		[Inject]
		public var stateModel:StateModel; 
		
		override public function execute():void 
		{
			stateModel.state = GameState.HEROES; 
		}		
		
	}

}