package com.la.mvc.controller.collection 
{
	import com.la.event.ApiServiceEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.collection.ICollection;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckInitCommand extends Command 
	{
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		override public function execute():void 
		{
			rootModel.currentState = GameState.EDIT_DECK;
			model.deckData = event.getData().deck;
			
			collection.setState (1);
			collection.initHero (event.getData().hero);
			collection.initBooks (event.getData().books);
			collection.initDeck (event.getData().deck);
			
		}		
	}

}