package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import flash.events.Event;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestNewDeckCommand extends StarlingCommand 
	{
		[Inject]
		public var service:ApiService;  
		
		[Inject]
		public var event:CollectionEvent;
		
		[Inject]
		public var rootModel:RootModel; 
		
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestNewDeckCommand::execute()')
			service.requestNewDeck (rootModel.userId, event.data.heroId);
		}
	}

}