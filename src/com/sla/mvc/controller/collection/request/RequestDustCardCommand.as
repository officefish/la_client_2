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
	public class RequestDustCardCommand extends StarlingCommand 
	{
		
		[Inject] 
		public var model:CollectionModel; 
		
		[Inject]
		public var service:ApiService;   
		
		[Inject] 
		public var rootModel:RootModel;  
		
		override public function execute():void 
		{
			MonsterDebugger.log('requestDustCard::execute()'); 
			var card:CollectionCard = model.drawingCard; 
			var cardId:int = card.getCardData().getId(); 
			var golden:Boolean = card.getCardData().isGolden()
			service.requestDestroyCard (rootModel.userId, cardId, golden);
		}
		
	}

}