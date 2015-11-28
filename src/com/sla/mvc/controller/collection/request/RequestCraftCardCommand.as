package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.service.ApiService;
	import com.sla.mvc.view.card.CollectionCard;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCraftCardCommand extends StarlingCommand 
	{
		
		[Inject]
		public var model:CollectionModel;
		
		[Inject]
		public var service:ApiService;
		
		[Inject]
		public var rootModel:RootModel; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('requestCraftCard::execute()');
			var card:CollectionCard = model.drawingCard; 
			var cardId:int = card.getCardData().getId();
			var golden:Boolean = card.getCardData().isGolden()
			
			service.requestCraftCard (rootModel.userId, cardId, golden);
		}
		
	}

}