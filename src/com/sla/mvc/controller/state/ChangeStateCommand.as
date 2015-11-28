package com.sla.mvc.controller.state 
{
	import com.sla.event.AbilityEvent;
	import com.sla.event.DeckListEvent;
	import com.sla.event.IntroEvent;
	import com.sla.event.LAContextEvent;
	import com.sla.event.LobbyEvent;
	import com.sla.event.MatchEvent;
	import com.sla.state.GameState;
	import com.sla.mvc.model.StateModel;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ChangeStateCommand extends StarlingCommand 
	{
		[Inject]
		public var stateModel:StateModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ("ChangeStateCommand::execute()");
			while (contextView.numChildren) contextView.removeChildAt (0);
			switch (stateModel.state) {
				case GameState.INTRO: {
					dispatch(new IntroEvent(IntroEvent.STARTUP));
					break;
				}
				case GameState.DECK_LIST: 
				{
					dispatch(new DeckListEvent(DeckListEvent.STARTUP));
					break;
				}
				case GameState.LOBBY: 
				{
					dispatch(new LobbyEvent(LobbyEvent.STARTUP));
					break;
				}
				case GameState.MATCH:
				{
					dispatch(new MatchEvent(MatchEvent.STARTUP));
					break;
				}
				case GameState.COLLECTION: {
					dispatch(new CollectionEvent(CollectionEvent.STARTUP));
					break;
				}
				case GameState.HEROES:
				{
					dispatch(new AbilityEvent(AbilityEvent.STARTUP));
					break;
				}
			}
			
		}		
	}

}