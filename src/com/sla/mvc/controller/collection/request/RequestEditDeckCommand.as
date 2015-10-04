package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestEditDeckCommand extends StarlingCommand 
	{
		[Inject]
		public var rootModel:RootModel;  
		
		[Inject]
		public var service:ApiService; 
		
		[Inject]
		public var event:CollectionEvent;
		
		override public function execute():void 
		{
			MonsterDebugger.log('RequestEditDeckCommand::execute');
			MonsterDebugger.log('deckId:' + event.data.deckId);
			service.requestEditDeck(rootModel.userId, event.data.deckId);
		}		
	}

}