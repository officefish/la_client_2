package com.sla.mvc.controller.bootstrap 
{
	import com.sla.event.ApiServiceEvent;
	import com.sla.event.DeckListEvent;
	import com.sla.event.LAContextEvent;
	import com.sla.event.LobbyEvent;
	import com.sla.event.LobbyServiceEvent;
	import com.sla.mvc.controller.decklist.CloseDeckListCommand;
	import com.sla.mvc.controller.decklist.DeckReadyToLobbyCommand;
	import com.sla.mvc.controller.decklist.IntroDecklistInitCommand;
	import com.sla.mvc.controller.decklist.request.RequestDeckReadyCommand;
	import com.sla.mvc.controller.decklist.request.RequestDeckListCommand;
	import com.sla.mvc.controller.decklist.StartupDeckListCommand;
	import com.sla.mvc.controller.lobby.InitPlayersCommand;
	import com.sla.mvc.controller.lobby.JoinToLobbyCommand;
	import com.sla.mvc.controller.lobby.LeaveLobbyCommand;
	import com.sla.mvc.controller.lobby.StartupLobbyCommand;
	import com.sla.mvc.controller.lobby.StartupLobbyServiceCommand;
	
	import com.sla.mvc.controller.intro.GameSelectCommand;
	import com.sla.mvc.controller.intro.StartupIntroCommand;
	import com.sla.mvc.controller.state.ChangeStateCommand;
	
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.ICommandMap;
	import com.sla.mvc.controller.init.*;
	import com.sla.event.IntroEvent;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapController 
	{
		public function BootstrapController(commandMap:ICommandMap)  
		{
			
			// -- Initialisation --
			/* All initialization realise in bootstrap classes but here we can configure some special things
			 * for example add some flashvars to model, configure service links, main theme, starling settings and so on 
			 */
			// init model
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitModelCommand, ContextEvent);
			// init services
			commandMap.mapEvent(LAContextEvent.MODEL_INIT, InitServiceCommand, LAContextEvent);
			// init view
			commandMap.mapEvent(LAContextEvent.SERVICE_INIT, InitViewCommand, LAContextEvent);
			// initialize complete
			commandMap.mapEvent(LAContextEvent.VIEW_INIT, InitializeCompleteCommand);
			
			//-- ChangeState --
			commandMap.mapEvent(LAContextEvent.VALIDATE, ChangeStateCommand);
			
			// -- Intro --
			/*
			 *  Finally we launch our intro menu 
			 */  
			commandMap.mapEvent(IntroEvent.STARTUP, StartupIntroCommand);
			commandMap.mapEvent(IntroEvent.SELECT_GAME, GameSelectCommand);
			
			commandMap.mapEvent(IntroEvent.COMPLETE, ChangeStateCommand);
			
			// -- Decklist before match --
			commandMap.mapEvent(DeckListEvent.STARTUP, StartupDeckListCommand);
			commandMap.mapEvent(DeckListEvent.REQUEST_DECKLIST, RequestDeckListCommand);
			commandMap.mapEvent(ApiServiceEvent.INTRO_DECKLIST_INIT, IntroDecklistInitCommand, ApiServiceEvent);
			commandMap.mapEvent(DeckListEvent.CLOSE, CloseDeckListCommand);
			commandMap.mapEvent(DeckListEvent.READY, RequestDeckReadyCommand, DeckListEvent);
			commandMap.mapEvent(ApiServiceEvent.DECK_READY_TO_LOBBY, DeckReadyToLobbyCommand, ApiServiceEvent);
			commandMap.mapEvent(DeckListEvent.COMPLETE, ChangeStateCommand);
			
			// -- Lobby --
			commandMap.mapEvent(LobbyEvent.STARTUP, StartupLobbyCommand);
			commandMap.mapEvent(LobbyEvent.CONNECT, StartupLobbyServiceCommand);
			commandMap.mapEvent(LobbyServiceEvent.PLAYERS_INIT, InitPlayersCommand, LobbyServiceEvent);
			commandMap.mapEvent(LobbyServiceEvent.USER_JOIN, JoinToLobbyCommand, LobbyServiceEvent);
			commandMap.mapEvent(LobbyServiceEvent.USER_LEAVE, LeaveLobbyCommand, LobbyServiceEvent);
		}
		
	}

}