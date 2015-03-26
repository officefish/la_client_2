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
	public class FullCollectionInitCommand extends Command 
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
			collection.setState (2);
			
			model.setDust (event.getData().dust);
			
			collection.setDust (event.getData().dust);
			collection.initBooks (event.getData().books);
		}		
	}
	


}