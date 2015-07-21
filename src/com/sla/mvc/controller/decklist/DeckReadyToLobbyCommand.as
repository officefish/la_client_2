package com.sla.mvc.controller.decklist 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.DeckListEvent;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.decklist.DeckList;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.event.ApiServiceEvent;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckReadyToLobbyCommand extends StarlingCommand 
	{
		[Inject]
		public var heroModel:HeroModel; 
		
		[Inject]
		public var event:ApiServiceEvent; 
		
		[Inject]
		public var stateModel:StateModel;
		
		
		override public function execute():void 
		{
			MonsterDebugger.log("DeckReadyForLobbyCommand::execute()");
			
			heroModel.heroId = event.data.hero_id;
			heroModel.deckId = event.data.deck_id;
			heroModel.type = event.data.hero_uid;
			heroModel.level = event.data.level;
			
			stateModel.state = GameState.LOBBY;
			
			dispatch(new DeckListEvent(DeckListEvent.COMPLETE));
		}		
	}

}