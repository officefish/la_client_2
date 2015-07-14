/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
import com.la.event.AchieveEvent;
import com.la.event.ActionEvent;
import com.la.event.ApiServiceEvent;
import com.la.event.CardEvent;
import com.la.event.CollectionEvent;
import com.la.event.DeckEvent;
import com.la.event.HeroesEvent;
import com.la.mvc.controller.achieves.AchieveCraftCompleteCommand;
import com.la.mvc.controller.achieves.AchieveDestroyCompleteCommand;
import com.la.mvc.controller.achieves.AchievesCraftListInitCommand;
import com.la.mvc.controller.achieves.AchievesListInitCommand;
import com.la.mvc.controller.achieves.CloseAchievesCommand;
import com.la.mvc.controller.achieves.CraftAchievePreviewCommand;
import com.la.mvc.controller.achieves.DisableAchieveCommand;
import com.la.mvc.controller.achieves.DragAchieveCardCommand;
import com.la.mvc.controller.achieves.DragAchieveSlotCommand;
import com.la.mvc.controller.achieves.EnableAchieveCommand;
import com.la.mvc.controller.achieves.IncrementAchieveCommand;
import com.la.mvc.controller.achieves.InitAchieveTatgetCommand;
import com.la.mvc.controller.achieves.MatchAchievePreviewCommand;
import com.la.mvc.controller.achieves.requests.RequestAchievesCraftListCommand;
import com.la.mvc.controller.achieves.requests.RequestAchieveSetupCommand;
import com.la.mvc.controller.achieves.requests.RequestActivateAchieveCommand;
import com.la.mvc.controller.achieves.requests.RequestActivateAchieveTotargetCommand;
import com.la.mvc.controller.achieves.requests.RequestCraftAchieveCommand;
import com.la.mvc.controller.achieves.requests.RequestDestroyAchieveCommand;
import com.la.mvc.controller.achieves.requests.RequestEditAchievesCommand;
import com.la.mvc.controller.achieves.WrongAchieveTargetCommand;
import com.la.mvc.controller.collection.CardCreatedCommand;
import com.la.mvc.controller.collection.CardDestroyedCommand;
import com.la.mvc.controller.collection.requests.RequestCraftReadyCommand;
import com.la.mvc.controller.collection.FullCollectionInitCommand;
import com.la.mvc.controller.collection.requests.RequestCraftCardCommand;
import com.la.mvc.controller.collection.requests.RequestCraftReadyCommand;
import com.la.mvc.controller.collection.requests.RequestDestroyCardCommand;
import com.la.mvc.controller.collection.requests.RequestFullCollectionCommand;
import com.la.mvc.controller.deck.ClearOverloadCommand;
import com.la.mvc.controller.deck.DropCardsCommand;
import com.la.mvc.controller.deck.OverloadCommand;
import com.la.mvc.controller.intro.SelectHeroesCommand;
import com.la.mvc.controller.loading.PreloadingCommand;
import com.la.mvc.controller.loading.PreloadingCompleteCommand;
import com.la.mvc.controller.match.attack.FreezeAttackCommand;
import com.la.mvc.controller.match.attack.MassiveKillCommand;
import com.la.mvc.controller.match.attack.PassiveAttackForSeveralTargets;
import com.la.mvc.controller.match.deck.AttritionCommand;
import com.la.mvc.controller.match.deck.BackSeveralTokensToHandCommand;
import com.la.mvc.controller.match.deck.BurnCardCommand;
import com.la.mvc.controller.match.deck.CancelSpellSelectCommand;
import com.la.mvc.controller.match.deck.CancelSpellSelectForEffectCommand;
import com.la.mvc.controller.match.deck.CopyUnitCardsToHandCommand;
import com.la.mvc.controller.match.deck.DragFieldDeckSlotCommand;
import com.la.mvc.controller.match.deck.drawing.SkipDrawingCommand;
import com.la.mvc.controller.match.deck.drawing.StartDrawingCommand;
import com.la.mvc.controller.match.deck.EndSpellSelectCommand;
import com.la.mvc.controller.match.deck.EndSpellSelectForEffectCommand;
import com.la.mvc.controller.match.deck.GlowCardsCommand;
import com.la.mvc.controller.match.deck.PreviewFieldDeckSlotCommand;
import com.la.mvc.controller.match.deck.ReplaceDeckItemsCommand;
import com.la.mvc.controller.match.deck.RequestReplaceDeckItemsCommand;
import com.la.mvc.controller.match.deck.ShuffleTokenIntoDeckCommand;
import com.la.mvc.controller.match.deck.SpellSelectCommand;
import com.la.mvc.controller.match.deck.WrongSpellSelectTargetCommand;
import com.la.mvc.controller.match.EndMatchCommand;
import com.la.mvc.controller.match.RequestEndMatchCommand;
import com.la.mvc.controller.match.scenario.actions.ActivateWidgetCommand;
import com.la.mvc.controller.match.scenario.actions.ChangeManaCommand;
import com.la.mvc.controller.match.scenario.actions.DamageCommand;
import com.la.mvc.controller.match.scenario.actions.DecreaseSpellCommand;
import com.la.mvc.controller.match.scenario.actions.EnticeTokenCommand;
import com.la.mvc.controller.match.scenario.actions.IncreaseSpellCommand;
import com.la.mvc.controller.match.scenario.actions.ReplaceCardAndToken;
import com.la.mvc.controller.match.scenario.actions.SelectEffectCommand;
import com.la.mvc.controller.match.scenario.actions.SelectGuiseCommand;
import com.la.mvc.controller.match.scenario.actions.SelectTargetForEffectCommand;
import com.la.mvc.controller.match.scenario.actions.SelectTargetForEffectCommand;
import com.la.mvc.controller.match.scenario.actions.UnitFromHandCommand;
import com.la.mvc.controller.match.scenario.glow.ActivateDrawingSeriesCommand;
import com.la.mvc.controller.match.scenario.glow.DeactivateDrawingSeriesCommand;
import com.la.mvc.controller.match.scenario.ShiftDeckSlotCommand;
import com.la.mvc.controller.match.select.ResponseEffectSelectedCommand;
import com.la.mvc.controller.match.select.ResponseGuiseSelectedCommand;
import com.la.mvc.view.card.AttritionCard;

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
import com.la.mvc.controller.collection.requests.RequestNewDeckCommand;
import com.la.mvc.controller.collection.requests.RequestEditDeckCommand;
import com.la.mvc.controller.collection.requests.RequestHeroesCommand;
import com.la.mvc.controller.collection.DragCollectionItemCommand;
import com.la.mvc.controller.collection.requests.RequestRemoveDeckCommand;
import com.la.mvc.controller.collection.ResetDeckCommand;
import com.la.mvc.controller.collection.SaveDeckCommand;
import com.la.mvc.controller.deck.CardsAddedCommand;
import com.la.mvc.controller.deck.DeckListInitCommand;
import com.la.mvc.controller.deck.DeckSelectCommand;
import com.la.mvc.controller.deck.requests.RequestIntroEditDeckCommand;
import com.la.mvc.controller.deck.requests.ResquestSelectDeckCommand;
import com.la.mvc.controller.deck.requests.RequestDeckListCommand;
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
		commandMap.mapEvent(IntroEvent.SELECT_HEROES, SelectHeroesCommand, IntroEvent);
        commandMap.mapEvent(IntroEvent.COMPLETE, ChangeStateCommand);
		
		// api service
		commandMap.mapEvent(ApiServiceEvent.REQUEST, PreloadingCommand, ApiServiceEvent);
		commandMap.mapEvent(ApiServiceEvent.REQUEST_COMPLETE, PreloadingCompleteCommand, ApiServiceEvent);
		
		// collection
		commandMap.mapEvent(ApiServiceEvent.COLLECTION_INIT, CollectionInitCommand, ApiServiceEvent); 
		commandMap.mapEvent(CardEvent.COLLECTION_CLICK, PreviewCollectionCardCommand, CardEvent);
		commandMap.mapEvent(CollectionEvent.CLOSE, CloseCollectionCommand, CollectionEvent);
		commandMap.mapEvent(CollectionEvent.NEW_DECK, RequestHeroesCommand);
		commandMap.mapEvent(ApiServiceEvent.HEROES_INIT, HeroesInitCommand, ApiServiceEvent);
		commandMap.mapEvent(CollectionEvent.SELECT_HERO, RequestNewDeckCommand, CollectionEvent);
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
		commandMap.mapEvent(CollectionEvent.CREATE_CARDS, RequestFullCollectionCommand, CollectionEvent);
		commandMap.mapEvent(ApiServiceEvent.FULL_COLLECTION_INIT, FullCollectionInitCommand, ApiServiceEvent);
		commandMap.mapEvent(CollectionEvent.CRAFT_READY, RequestCraftReadyCommand, CollectionEvent);
		commandMap.mapEvent(CollectionEvent.CRAFT_CARD, RequestCraftCardCommand, CollectionEvent);	
		commandMap.mapEvent(ApiServiceEvent.CARD_CREATED, CardCreatedCommand, ApiServiceEvent);
		commandMap.mapEvent(CollectionEvent.DESTROY_CARD, RequestDestroyCardCommand, CollectionEvent);
        commandMap.mapEvent(ApiServiceEvent.CARD_DESTROYED, CardDestroyedCommand, ApiServiceEvent);
		
		// heroes
		commandMap.mapEvent(HeroesEvent.CHOOSE_HERO_FOR_CRAFT, RequestHeroesCommand);
		commandMap.mapEvent(HeroesEvent.SELECT_HERO, RequestEditAchievesCommand, HeroesEvent);
		commandMap.mapEvent(ApiServiceEvent.ACHIEVES_LIST_INIT, AchievesListInitCommand, ApiServiceEvent);
		commandMap.mapEvent(CardEvent.DRAG_ACHIEVE_CARD, DragAchieveCardCommand, CardEvent);
		commandMap.mapEvent(CardEvent.DRAG_ACHIEVE_SLOT, DragAchieveSlotCommand, CardEvent);
		commandMap.mapEvent(AchieveEvent.SAVE, RequestAchieveSetupCommand, AchieveEvent);
		commandMap.mapEvent(ApiServiceEvent.SETUP_SERVICE_COMPLETE, CloseAchievesCommand);
		commandMap.mapEvent(AchieveEvent.CLOSE, CloseAchievesCommand);
		commandMap.mapEvent(AchieveEvent.CREATE, RequestAchievesCraftListCommand, AchieveEvent);
		commandMap.mapEvent(ApiServiceEvent.ACHIEVES_CRAFT_LIST_INIT, AchievesCraftListInitCommand, ApiServiceEvent);
		commandMap.mapEvent(CardEvent.CRAFT_ACHIEVE, CraftAchievePreviewCommand, CardEvent);
		commandMap.mapEvent(AchieveEvent.CRAFT, RequestCraftAchieveCommand, AchieveEvent);
		commandMap.mapEvent(AchieveEvent.DESTROY, RequestDestroyAchieveCommand, AchieveEvent);
		commandMap.mapEvent(ApiServiceEvent.ACHIEVE_CRAFT_COMPLETE, AchieveCraftCompleteCommand, ApiServiceEvent);
		commandMap.mapEvent(ApiServiceEvent.ACHIEVE_DESTROY_COMPLETE, AchieveDestroyCompleteCommand, ApiServiceEvent);
		
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
		
		// freeze 
		commandMap.mapEvent(SceneEvent.FREEZE_ATTACK, FreezeAttackCommand, SceneEvent); 
		
		// replace card and token
		commandMap.mapEvent(SceneEvent.REPLACE_CARD_AND_TOKEN, ReplaceCardAndToken, SceneEvent);
		
		// entice unit
		commandMap.mapEvent(SceneEvent.ENTICE_UNIT, EnticeTokenCommand, SceneEvent);
		
		commandMap.mapEvent(SceneEvent.ACTIVATE_WIDGET, ActivateWidgetCommand, SceneEvent);
		
		// play spell
		commandMap.mapEvent(DeckEvent.SPELL_SELECT, SpellSelectCommand, DeckEvent); 
		commandMap.mapEvent(DeckEvent.END_SPELL_SELECT, EndSpellSelectCommand, DeckEvent);
		commandMap.mapEvent(DeckEvent.CANSEL_SPELL_SELECT, CancelSpellSelectCommand, DeckEvent);
		commandMap.mapEvent(DeckEvent.WRONG_SPELL_SELECT_TARGET, WrongSpellSelectTargetCommand, DeckEvent);
		
		// increase/decrease spell mixin
		commandMap.mapEvent(SceneEvent.INCREASE_SPELL, IncreaseSpellCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.DECREASE_SPELL, DecreaseSpellCommand, SceneEvent);
		
		commandMap.mapEvent(SceneEvent.CHANGE_MANA, ChangeManaCommand, SceneEvent); 
		commandMap.mapEvent(SceneEvent.PASSIVE_ATTACK_FOR_SEVERAL_TARGETS, PassiveAttackForSeveralTargets, SceneEvent);
		
		commandMap.mapEvent(DeckEvent.START_DRAWING, StartDrawingCommand, DeckEvent);
		commandMap.mapEvent(DeckEvent.SKIP_DRAWING, SkipDrawingCommand, DeckEvent);
		commandMap.mapEvent(DeckEvent.GLOW_CARDS, GlowCardsCommand, DeckEvent);
		
		commandMap.mapEvent(SceneEvent.ACTIVATE_DRAWING_SERIES, ActivateDrawingSeriesCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.DEACTIVATE_DRAWING_SERIES, DeactivateDrawingSeriesCommand, SceneEvent);
		
		commandMap.mapEvent(SceneEvent.OVERLOAD, OverloadCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.CLEAR_OVERLOAD, ClearOverloadCommand, SceneEvent);
		
		commandMap.mapEvent(SceneEvent.DROP_CARDS, DropCardsCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.SELECT_EFFECT, SelectEffectCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.EFFECT_SELECTED, ResponseEffectSelectedCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.SELECT_TARGET_FOR_EFFECT, SelectTargetForEffectCommand, SceneEvent);
		commandMap.mapEvent(DeckEvent.CANCEL_SPELL_SELECT_FOR_EFFECT, CancelSpellSelectForEffectCommand, DeckEvent);
		commandMap.mapEvent(DeckEvent.END_SPELL_SELECT_FOR_EFFECT, EndSpellSelectForEffectCommand, DeckEvent);
		
		commandMap.mapEvent(SceneEvent.SELECT_GUISE, SelectGuiseCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.GUISE_SELECTED, ResponseGuiseSelectedCommand, SceneEvent);
		
		commandMap.mapEvent(SceneEvent.DAMAGE, DamageCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.UNIT_FROM_HAND, UnitFromHandCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.MASSIVE_KILL, MassiveKillCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.SHUFFLE_UNIT_INTO_DECK, ShuffleTokenIntoDeckCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.BACK_SEVERAL_TOKENS_TO_HAND, BackSeveralTokensToHandCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.COPY_UNIT_CARDS_TO_HAND, CopyUnitCardsToHandCommand, SceneEvent);
		
		commandMap.mapEvent(SceneEvent.BURN_CARD, BurnCardCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.ATTRITION, AttritionCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.END_MATCH, RequestEndMatchCommand, SceneEvent);
		commandMap.mapEvent(MatchServiceEvent.END_MATCH, EndMatchCommand, MatchServiceEvent);
		
		// match achieves
		commandMap.mapEvent(FieldEvent.ACHIEVE_PREVIEW, MatchAchievePreviewCommand, FieldEvent);
		commandMap.mapEvent(SceneEvent.INCREMENT_ACHIEVE, IncrementAchieveCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.DISABLE_ACHIEVE, DisableAchieveCommand, SceneEvent);
		commandMap.mapEvent(SceneEvent.ENABLE_ACHIEVE, EnableAchieveCommand, SceneEvent);
		commandMap.mapEvent(FieldEvent.ACTIVATE_SPELL_ACHIEVE, RequestActivateAchieveCommand, FieldEvent);
		commandMap.mapEvent(FieldEvent.ACTIVATE_SPELL_TO_TARGET_ACHIEVE, InitAchieveTatgetCommand, FieldEvent);
		commandMap.mapEvent(FieldEvent.ACHIEVE_TARGET_INIT, RequestActivateAchieveTotargetCommand, FieldEvent);
		
		//
		commandMap.mapEvent(DeckEvent.PREVIEW_FIELD_DECK_SLOT, PreviewFieldDeckSlotCommand, DeckEvent);
		commandMap.mapEvent(DeckEvent.FIELD_DECK_SLOT_DOWN, DragFieldDeckSlotCommand, DeckEvent);
		commandMap.mapEvent(DeckEvent.REPLACE_DECK_ITEMS, RequestReplaceDeckItemsCommand, DeckEvent);
		commandMap.mapEvent(MatchServiceEvent.REPLACE_DECK_ITEMS, ReplaceDeckItemsCommand, MatchServiceEvent);
		commandMap.mapEvent(ScenarioEvent.SHIFT_DECK_SLOT, ShiftDeckSlotCommand, ScenarioEvent);
		
		commandMap.mapEvent(DeckEvent.WRONG_ACHIEVE_TARGET, WrongAchieveTargetCommand, DeckEvent);
		
		}
}
}
