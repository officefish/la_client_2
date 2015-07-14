package com.la.mvc.controller.deck.requests {
	import com.la.event.DeckEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.DeckData;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.ApiService;
	import com.la.mvc.view.collection.ICollection;
	import com.la.mvc.view.deck.DeckList;
	import com.la.state.GameState;
	import fl.controls.List;
	import flash.display.DisplayObject;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestIntroEditDeckCommand extends Command 
	{
		[Inject]
		public var event:DeckEvent;
		
		[Inject]
		public var service:ApiService;  
		
		[Inject (name='deckList')]
		public var list:DeckList; 
		
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		override public function execute():void 
		{
			
			rootModel.currentState = GameState.EDIT_DECK;
			model.deckData = event.data.deckData; 
			
			contextView.removeChild (list);
			contextView.addChild (collection as DisplayObject);
						
			var deckData:DeckData = event.data.deckData;
			service.editDeck (rootModel.userId, deckData.id);  		
		}		
	}

}