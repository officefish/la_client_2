package com.la.mvc.controller.collection.requests {
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.ApiService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestNewDeckCommand extends Command 
	{
		
		[Inject]
		public var service:ApiService;  
		
		[Inject]
		public var event:CollectionEvent;
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel; 
		
		override public function execute():void 
		{
			service.createDeck (rootModel.userId, event.getData()['hero_id'])
		}				
		
		
		
	}

}