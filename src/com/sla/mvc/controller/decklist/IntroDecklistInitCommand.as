package com.sla.mvc.controller.decklist {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.DeckListModel;
	import com.sla.mvc.view.decklist.DeckList;
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
			if (event.data['actualDeck']) {
				model.actualDeck = event.data['actualDeck'];
			}
			
			list.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(list);
			
			MonsterDebugger.log(model.list);
			
			list.initDecks(model.list);
			if (model.actualDeck) {
				list.activateDeck(model.actualDeck);
			}
			
			super.execute();
		}	
		
		
	}

}