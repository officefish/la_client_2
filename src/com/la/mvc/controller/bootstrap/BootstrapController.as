/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
import com.la.event.ActionEvent;
import com.la.event.ApiServiceEvent;
import com.la.event.CardEvent;
import com.la.event.CollectionEvent;
import com.la.event.DeckEvent;

import com.la.event.FieldEvent;
import com.la.event.LobbyEvent;
import com.la.event.LobbyServiceEvent;
import com.la.event.MatchEvent;
import com.la.event.MatchServiceEvent;
import com.la.event.ScenarioEvent;
import com.la.event.SceneEvent;
import com.la.event.TokenEvent;
import com.la.mvc.controller.collection.AddDectItemCommand;
import com.la.mvc.controller.collection.CloseCollectionCommand;
import com.la.mvc.controller.collection.CollectionInitCommand;
import com.la.mvc.controller.collection.DragSlotDeckCommand;
import com.la.mvc.controller.collection.DeckInitCommand;
import com.la.mvc.controller.collection.HeroesInitCommand;
import com.la.mvc.controller.collection.PreviewCollectionCardCommand;
import com.la.mvc.controller.collection.RemoveDeckItemCommand;
import com.la.mvc.controller.collection.NewDeckCommand;
import com.la.mvc.controller.collection.RequestEditDeckCommand;
import com.la.mvc.controller.collection.RequestHeroesCommand;
import com.la.mvc.controller.collection.DragCollectionItemCommand;
import com.la.mvc.controller.collection.RequestRemoveDeckCommand;
import com.la.mvc.controller.collection.ResetDeckCommand;
import com.la.mvc.controller.collection.SaveDeckCommand;
import com.la.mvc.controller.deck.CardsAddedCommand;
import com.la.mvc.controller.deck.DeckListInitCommand;
import com.la.mvc.controller.deck.DeckSelectCommand;
import com.la.mvc.controller.deck.RequestIntroEditDeckCommand;
import com.la.mvc.controller.deck.ResquestSelectDeckCommand;
import com.la.mvc.controller.deck.RequestDeckListCommand;
import com.la.mvc.controller.deck.StartupDeckListCommand;
import com.la.mvc.controller.init.InitModelCommand;
import com.la.mvc.controller.init.InitServiceCommand;
import com.la.mvc.controller.init.InitViewCommand;
import com.la.mvc.controller.lobby.CloseLobbyCommand;
import com.la.mvc.controller.match.attack.PassiveAttackCommand;
import com.la.mvc.controller.match.attack.ResponseClassicAttackCommand;
import com.la.mvc.controller.match.attack.StartAttackCommand;
import com.la.mvc.controller.match.ChangeOpponentPreflopCommand;
import com.la.mvc.controller.match.ChangePreflopCommand;
import com.la.mvc.controller.match.deck.BackTokenToHandCommand;

import com.la.mvc.controller.match.EndPreflopCommand;
import com.la.mvc.controller.match.OpponentPreflopClickCommand;
import com.la.mvc.controller.match.PlayerCardAddedCommand;
import com.la.mvc.controller.match.PreflopClickCommand;
import com.la.mvc.controller.match.scenario.ScenarioActionCommand;
import com.la.mvc.controller.match.scenario.ScenarioCommand;
import com.la.mvc.controller.match.select.CancelSelectForEptCommand;
import com.la.mvc.controller.match.select.ScenarioEndSelectCommand;
import com.la.mvc.controller.match.select.SelectForEptitudeInitCommand;
import com.la.mvc.controller.match.select.SelectUnitsForEptitudeCommand;
import com.la.mvc.controller.match.step.EndStepCommand;

import com.la.mvc.controller.match.LightenCompleteCommand;
import com.la.mvc.controller.match.ResponsePreflopInitCommand;
import com.la.mvc.controller.match.StartupMatchServiceCommand;
import com.la.mvc.controller.match.deck.FindPositionCommand;
import com.la.mvc.controller.match.deck.StopFindPositionCommand;
import com.la.mvc.controller.match.step.TimerEndStepCommand;
import com.la.mvc.controller.match.token.TokenPreviewCommand;

import com.la.mvc.controller.state.ChangeStateCommand;
import com.la.mvc.controller.intro.SelectArenaCommand;
import com.la.mvc.controller.intro.SelectCollectionCommand;
import com.la.mvc.controller.intro.SelectGameCommand;
import com.la.mvc.controller.intro.SelectMarketCommand;
import com.la.mvc.controller.intro.SelectQuestCommand;
import com.la.mvc.controller.intro.SelectStudyCommand;
import com.la.event.GameContextEvent;
import com.la.event.IntroEvent;
import com.la.mvc.controller.lobby.AcceptCommand;
import com.la.mvc.controller.lobby.CancelCommand;
import com.la.mvc.controller.lobby.InitPlayersCommand;
import com.la.mvc.controller.lobby.InviteCommand;
import com.la.mvc.controller.lobby.JoinToLobbyCommand;
import com.la.mvc.controller.lobby.RejectCommand;
import com.la.mvc.controller.lobby.StartupLobbyCommand;
import com.la.mvc.controller.lobby.StartupLobbyServiceCommand;
import com.la.mvc.controller.match.InitMatchModelCommand;
import com.la.mvc.controller.match.MatchConnectionInitCommand;
import com.la.mvc.controller.match.PreflopCompleteCommand;
import com.la.mvc.controller.match.WelcomeCompleteCommand;
import com.la.mvc.controller.match.ResponseChangePreflopCommand;
import com.la.mvc.controller.match.StartupMatchCommand;
import com.la.mvc.controller.match.WelcomeMatchCommand;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.core.ICommandMap;

import com.la.mvc.controller.debug.DebugCommand;
import com.la.event.ConsoleEvent;

import com.la.mvc.controller.match.deck.ResponseCardPlayCommand;




public class BootstrapController {
    public function BootstrapController(commandMap:ICommandMap) {

         // debug
		commandMap.mapEvent(ConsoleEvent.DEBUG, DebugCommand, ConsoleEvent);
		
		// Launch application;
		// init model
        commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitModelCommand, ContextEvent);
        // init services
        commandMap.mapEvent(GameContextEvent.MODEL_INIT_COMPLETE, InitServiceCommand, GameContextEvent);
        // init view
        commandMap.mapEvent(GameContextEvent.SERVICE_INIT_COMPLETE, InitViewCommand, GameContextEvent);

        // intro
        commandMap.mapEvent(IntroEvent.SELECT_GAME,SelectGameCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_COLLECTION, SelectCollectionCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_STUDY, SelectStudyCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_MARKET, SelectMarketCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_QUEST, SelectQuestCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.SELECT_ARENA, SelectArenaCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.COMPLETE, ChangeStateCommand);
		
		// collection
		commandMap.mapEvent(ApiServiceEvent.COLLECTION_INIT, CollectionInitCommand, ApiServiceEvent); 
		commandMap.mapEvent(CardEvent.COLLECTION_CLICK, PreviewCollectionCardCommand, CardEvent);
		commandMap.mapEvent(CollectionEvent.CLOSE, CloseCollectionCommand, CollectionEvent);
		commandMap.mapEvent(CollectionEvent.NEW_DECK, RequestHeroesCommand, CollectionEvent);
		commandMap.mapEvent(ApiServiceEvent.HEROES_INIT, HeroesInitCommand, ApiServiceEvent);
		commandMap.mapEvent(CollectionEvent.SELECT_HERO, NewDeckCommand, CollectionEvent);
		commandMap.mapEvent(ApiServiceEvent.NEW_DECK_INIT, DeckInitCommand, ApiServiceEvent);
		commandMap.mapEvent(CardEvent.DRAG_CARD, DragCollectionItemCommand, CardEvent);
		commandMap.mapEvent(CollectionEvent.ADD_DECK_ITEM, AddDectItemCommand, CollectionEvent);
		commandMap.mapEvent(CardEvent.DRAG_SLOT, DragSlotDeckCommand, CardEvent);
		commandMap.mapEvent(CollectionEvent.REMOVE_DECK_ITEM, RemoveDeckItemCommand, CollectionEvent);
		commandMap.mapEvent(CollectionEvent.SAVE_DECK, SaveDeckCommand, CollectionEvent);
		commandMap.mapEvent(CollectionEvent.RESET_DECK, ResetDeckCommand, CollectionEvent);
		commandMap.mapEvent(CollectionEvent.REMOVE_DECK, RequestRemoveDeckCommand, CollectionEvent);
		commandMap.mapEvent(CollectionEvent.EDIT_DECK, RequestEditDeckCommand, CollectionEvent);
		commandMap.mapEvent(ApiServiceEvent.EDIT_DECK_INIT, DeckInitCommand, ApiServiceEvent);

		
        // deckList
        commandMap.mapEvent(DeckEvent.STARTUP_DECK_LIST, StartupDeckListCommand, DeckEvent);
        commandMap.mapEvent(DeckEvent.STARTUP_DECK_SERVICE, RequestDeckListCommand, DeckEvent);
        commandMap.mapEvent(ApiServiceEvent.INTRO_DECK_LIST_INIT, DeckListInitCommand, ApiServiceEvent);
        commandMap.mapEvent(DeckEvent.SELECT_DECK, ResquestSelectDeckCommand, DeckEvent);
        commandMap.mapEvent(ApiServiceEvent.INTRO_DECK_SELECT, DeckSelectCommand, ApiServiceEvent);
        commandMap.mapEvent(DeckEvent.CLOSE, ChangeStateCommand);
		commandMap.mapEvent(DeckEvent.INTRO_EDIT_CLICK, RequestIntroEditDeckCommand, DeckEvent);

        // lobby
        commandMap.mapEvent(LobbyEvent.STARTUP_LOBBY, StartupLobbyCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.STARTUP_LOBBY_SERVICE, StartupLobbyServiceCommand, LobbyEvent);
        commandMap.mapEvent(LobbyServiceEvent.PLAYERS_INIT, InitPlayersCommand, LobbyServiceEvent);
        commandMap.mapEvent(LobbyServiceEvent.USER_JOIN, JoinToLobbyCommand, LobbyServiceEvent);

        commandMap.mapEvent(LobbyEvent.INVITE, InviteCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.ACCEPT, AcceptCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.REJECT, RejectCommand, LobbyEvent);
        commandMap.mapEvent(LobbyEvent.CANCEL, CancelCommand, LobbyEvent);

        commandMap.mapEvent(LobbyServiceEvent.ACCEPT_INVITATION, CloseLobbyCommand, LobbyServiceEvent);
        commandMap.mapEvent(LobbyEvent.CLOSE, ChangeStateCommand);

        // match
        commandMap.mapEvent(MatchEvent.STARTUP_MATCH, StartupMatchCommand, MatchEvent);
        commandMap.mapEvent(MatchEvent.STARTUP_COMPLETE, StartupMatchServiceCommand, MatchEvent);

        // preflop
        commandMap.mapEvent(MatchServiceEvent.CONNECTION_INIT, MatchConnectionInitCommand, MatchServiceEvent);
        commandMap.mapEvent(MatchServiceEvent.PREFLOP_INIT, WelcomeMatchCommand, MatchServiceEvent);
        commandMap.mapEvent(MatchEvent.INIT_MATCH_MODEL, InitMatchModelCommand, MatchEvent);
        commandMap.mapEvent(MatchEvent.COLLECTION_INIT, WelcomeMatchCommand, MatchEvent);
        commandMap.mapEvent(SceneEvent.WELCOME_COMPLETE, WelcomeCompleteCommand, SceneEvent);
        commandMap.mapEvent(SceneEvent.CHANGE_PREFLOP, ResponseChangePreflopCommand, SceneEvent);
        commandMap.mapEvent(MatchServiceEvent.CHANGE_PREFLOP, ChangePreflopCommand, MatchServiceEvent);
        commandMap.mapEvent(SceneEvent.PREFLOP_INIT, ResponsePreflopInitCommand, SceneEvent);
        commandMap.mapEvent(DeckEvent.CARDS_ADDED, CardsAddedCommand, DeckEvent);
        commandMap.mapEvent(SceneEvent.PREFLOP_COMPLETE, PreflopCompleteCommand, SceneEvent);

        commandMap.mapEvent(CardEvent.PREFLOP_CLICK, PreflopClickCommand, CardEvent);
        commandMap.mapEvent(MatchServiceEvent.OPPONENT_PREFLOP_CLICK, OpponentPreflopClickCommand, MatchServiceEvent);
        commandMap.mapEvent(MatchServiceEvent.CHANGE_OPPONENT_PREFLOP, ChangeOpponentPreflopCommand, MatchServiceEvent);

        commandMap.mapEvent(MatchServiceEvent.END_PREFLOP, EndPreflopCommand, MatchServiceEvent);
        commandMap.mapEvent(SceneEvent.LIGHTEN_COMPLETE, LightenCompleteCommand, SceneEvent);
		
		//token
		commandMap.mapEvent(TokenEvent.PREVIEW, TokenPreviewCommand, TokenEvent);

        // step
        commandMap.mapEvent(DeckEvent.PLAYER_CARD_ADDED, PlayerCardAddedCommand, DeckEvent);
		commandMap.mapEvent(FieldEvent.END_STEP, EndStepCommand, FieldEvent);
		commandMap.mapEvent(MatchServiceEvent.END_STEP_TIMER, TimerEndStepCommand, MatchServiceEvent);

        // playCard
        commandMap.mapEvent(DeckEvent.FIND_POSITION, FindPositionCommand, DeckEvent);
        commandMap.mapEvent(DeckEvent.STOP_FIND_POSITION, StopFindPositionCommand, DeckEvent);
        commandMap.mapEvent(DeckEvent.PLAYER_CARD_PLAY, ResponseCardPlayCommand, DeckEvent);
		
		// scenario
		commandMap.mapEvent(MatchServiceEvent.SCENARIO, ScenarioCommand, MatchServiceEvent);
		commandMap.mapEvent(ScenarioEvent.ACTION, ScenarioActionCommand, ScenarioEvent);
		
		// select for eptitude
		commandMap.mapEvent(SceneEvent.SELECT_FOR_EPTITUDE, SelectUnitsForEptitudeCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.SELECT_FOR_EPTITUDE_INIT, SelectForEptitudeInitCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.SCENARIO_END_SELECT_UNIT, ScenarioEndSelectCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.CANCEL_SELECT_FOR_EPTITUDE_UNIT, CancelSelectForEptCommand, SceneEvent);
		
		// back token to hand
		commandMap.mapEvent(SceneEvent.BACK_TOKEN_TO_HAND, BackTokenToHandCommand, SceneEvent);
		
		// attack
		commandMap.mapEvent(TokenEvent.ATTACK, StartAttackCommand, TokenEvent);
		commandMap.mapEvent(ActionEvent.CLASSIC_ATTACK, ResponseClassicAttackCommand, ActionEvent);
		
		// passive attack
		commandMap.mapEvent(SceneEvent.PASSIVE_ATTACK, PassiveAttackCommand, SceneEvent);

    }
}
}
