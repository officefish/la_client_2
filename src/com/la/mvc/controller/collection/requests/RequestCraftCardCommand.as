package com.la.mvc.controller.collection.requests {
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.ApiService;
	import com.la.mvc.view.card.CollectionCard;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestCraftCardCommand extends Command 
	{
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject]
		public var service:ApiService;  
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel;  
		
		override public function execute():void 
		{
			var card:CollectionCard = model.collectionCard; 
			var cardId:int = card.getCardData().getId();
			
			var golden:Boolean = card.getCardData().isGolden()
			
			service.craftCard (rootModel.userId, cardId, golden);
		}	
	}

}