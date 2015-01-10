package com.la.mvc.controller.collection 
{
	import com.la.event.ApiServiceEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.view.collection.ICollection;
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
		
		override public function execute():void 
		{
			//trace (event.getData())
			collection.setState (0);
			collection.initBooks (event.getData().books);
			collection.initDecks (event.getData().decks);
			
		}
	}

}