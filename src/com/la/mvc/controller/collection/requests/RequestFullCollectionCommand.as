package com.la.mvc.controller.collection.requests {
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.ApiService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestFullCollectionCommand extends Command 
	{
		[Inject]
		public var service:ApiService;  
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel;  
		
		override public function execute():void 
		{
			service.fullCollection (rootModel.userId); 
		}		
	}

}