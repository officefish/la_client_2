package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckInitCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject] 
		public var collection:Collection; 
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var collectionModel:CollectionModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('DeckInitCommand');
			
			contextView.removeChildren();
			contextView.addChildAt(collection, 0);
			collection.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			
			stateModel.state = GameState.EDIT_DECK;
			collectionModel.deckData = event.data.deck;
						
			collection.setState (1);
			collection.initHero (event.data.hero);
			collection.initBooks (event.data.books);
			collection.initDeck (event.data.deck);
		}
	}

}