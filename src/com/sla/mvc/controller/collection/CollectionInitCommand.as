package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionInitCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ApiServiceEvent; 
		
		[Inject]
		public var collection:Collection; 
		
		[Inject]
		public var stateModel:StateModel; 

		
		override public function execute():void 
		{
			MonsterDebugger.log ('CollectionInitCommand::execute()');
			
			stateModel.state = GameState.COLLECTION;
			
			collection.setState (0);
			collection.initBooks (event.data.books);
			collection.initDecks (event.data.decks);
			
		}
		
	}

}