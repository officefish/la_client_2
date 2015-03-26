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
	public class CollectionInitCommand extends Command 
	{
		
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel;
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel; 

		
		override public function execute():void 
		{
			rootModel.currentState = GameState.COLLECTION;
			
			collection.setState (0);
			collection.initBooks (event.getData().books);
			collection.initDecks (event.getData().decks);
		}
	}

}