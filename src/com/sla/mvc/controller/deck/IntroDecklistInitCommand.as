package com.sla.mvc.controller.deck 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.DeckListModel;
	import com.sla.mvc.view.deck.DeckList;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class IntroDecklistInitCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject]
		public var list:DeckList;
		
		[Inject]
		public var model:DeckListModel;
		
		override public function execute():void 
		{
			model.list = event.data['decks'];
			
			list.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(list);
			
			list.initDecks(model.list);
			
			super.execute();
		}	
		
		
	}

}