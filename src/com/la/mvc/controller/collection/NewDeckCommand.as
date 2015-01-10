package com.la.mvc.controller.collection 
{
	import com.la.event.CollectionEvent;
	import com.la.mvc.service.ApiService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class NewDeckCommand extends Command 
	{
		
		[Inject]
		public var service:ApiService;  
		
		[Inject]
		public var event:CollectionEvent;
		
		override public function execute():void 
		{
			service.createDeck (1, event.getData()['hero_id'])
		}				
		
		
		
	}

}