package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCollectionCommand extends StarlingCommand 
	{
		
		[Inject]
		public var service:ApiService; 
		
		[Inject]
		public var event:CollectionEvent;

		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestCollectionCommand::execute()');
			service.requestCollection(event.data.userId);
		}
		
	}

}