package com.la.mvc.controller.collection 
{
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
		
		override public function execute():void 
		{
			service.fullCollection (1); 
		}		
	}

}