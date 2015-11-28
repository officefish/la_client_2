package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.service.ApiService;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCraftReadyCommand extends StarlingCommand 
	{
		
		[Inject]
		public var service:ApiService; 
		
		[Inject] 
		public var rootModel:RootModel;
		
		[Inject]
		public var stateModel:StateModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestCraftReadyCommand::execute()');
			stateModel.state = GameState.COLLECTION; 
			service.requestCollection (rootModel.userId); 
		}
		
	}

}