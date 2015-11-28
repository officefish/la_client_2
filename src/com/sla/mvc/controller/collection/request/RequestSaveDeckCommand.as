package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestSaveDeckCommand extends StarlingCommand 
	{
		[Inject]
		public var event:CollectionEvent;
		
		[Inject]
		public var collectionModel:CollectionModel;
		
		[Inject] 
		public var service:ApiService;  
		
		[Inject]
		public var rootModel:RootModel;  
		
		override public function execute():void 
		{
			MonsterDebugger.log ('RequestSaveDeckCommand::execute');
			
			var deckId:int = collectionModel.deckData.id;
			var items:Array = event.data.items;
			var deckTitle:String = event.data.title;
			
			service.requestSaveDeck (rootModel.userId, deckId, deckTitle, items);
		}		
	}

}