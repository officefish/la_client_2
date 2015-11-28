package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.view.collection.Collection;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FullCollectionInitCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject]
		public var collection:Collection; 
		
		[Inject]
		public var model:CollectionModel; 
		
		override public function execute():void 
		{
			MonsterDebugger.log ('FullCollectionInitCommand::execute()');
			collection.setState (2);
			
			model.dust = event.data.dust;
			collection.setDust (event.data.dust);
			
			collection.initBooks (event.data.books);
		}
		
	}

}