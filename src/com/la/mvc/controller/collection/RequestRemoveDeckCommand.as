package com.la.mvc.controller.collection 
{
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.DeckData;
	import com.la.mvc.service.ApiService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestRemoveDeckCommand extends Command 
	{
		
		[Inject]
		public var event:CollectionEvent;
		
		[Inject]
		public var service:ApiService; 
		
		override public function execute():void 
		{
			var deckData:DeckData = event.getData().deckData;
			service.removeDeck (1, deckData.id);
		}		
	}

}