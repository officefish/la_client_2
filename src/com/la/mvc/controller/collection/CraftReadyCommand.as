package com.la.mvc.controller.collection 
{
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.ApiService;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftReadyCommand extends Command 
	{
		[Inject]
		public var service:ApiService; 
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel; 

		
		override public function execute():void 
		{
			rootModel.currentState = GameState.COLLECTION;
			service.requestCollection (1); 
		}
	}

}