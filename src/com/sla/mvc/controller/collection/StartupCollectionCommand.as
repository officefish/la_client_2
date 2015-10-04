package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupCollectionCommand extends StarlingCommand 
	{
		
		[Inject]
		public var collection:Collection;
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var rootModel:RootModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('StartupCollectionCommand::execute()');
			
			contextView.addChildAt(collection, 0);
			collection.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			stateModel.state = GameState.COLLECTION;
			
			dispatch(new CollectionEvent(CollectionEvent.REQUEST_COLLECTION, { userId:rootModel.userId }));
		}
		
	}

}