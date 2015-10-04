package com.sla.mvc.controller.bootstrap 
{
	
	import com.sla.event.ApiServiceEvent;
	import com.sla.event.CollectionEvent;
	import com.sla.event.DeckListEvent;
	import com.sla.event.FieldEvent;
	import com.sla.event.HandEvent;
	import com.sla.event.LAContextEvent;
	import com.sla.event.LobbyEvent;
	import com.sla.event.LobbyServiceEvent;
	import com.sla.event.MatchEvent;
	import com.sla.event.MatchServiceEvent;
	import com.sla.event.ScenarioEvent;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.controller.collection.AddToDeckCommand;
	import com.sla.mvc.controller.collection.CollectionInitCommand;
	import com.sla.mvc.controller.collection.DeckInitCommand;
	import com.sla.mvc.controller.collection.request.RequestCollectionCommand;
	import com.sla.mvc.controller.collection.request.RequestEditDeckCommand;
	import com.sla.mvc.controller.collection.request.RequestRemoveDeckCommand;
	import com.sla.mvc.controller.collection.StartupCollectionCommand;
	import com.sla.mvc.controller.collection.PreviewCollectionCardCommand;
	import com.sla.mvc.controller.decklist.CloseDeckListCommand;
	import com.sla.mvc.controller.decklist.DeckReadyToLobbyCommand;
	import com.sla.mvc.controller.decklist.IntroDecklistInitCommand;
	import com.sla.mvc.controller.decklist.request.RequestDeckReadyCommand;
	import com.sla.mvc.controller.decklist.request.RequestDeckListCommand;
	import com.sla.mvc.controller.decklist.StartupDeckListCommand;
	import com.sla.mvc.controller.intro.CollectionSelectCommand;
	import com.sla.mvc.controller.lobby.CancelCommand;
	import com.sla.mvc.controller.lobby.CloseLobbyCommand;
	import com.sla.mvc.controller.lobby.dispather.DispatcherCancelCommand;
	import com.sla.mvc.controller.lobby.dispather.DispatcherConfirmCancelCommand;
	import com.sla.mvc.controller.lobby.dispather.DispatcherConfirmInviteCommand;
	import com.sla.mvc.controller.lobby.dispather.DispatcherInviteCommand;
	import com.sla.mvc.controller.lobby.ForceCloseLobbyCommand;
	import com.sla.mvc.controller.lobby.InitPlayersCommand;
	import com.sla.mvc.controller.lobby.JoinToLobbyCommand;
	import com.sla.mvc.controller.lobby.LeaveLobbyCommand;
	import com.sla.mvc.controller.lobby.StartupLobbyCommand;
	import com.sla.mvc.controller.lobby.StartupLobbyServiceCommand;
	import com.sla.mvc.controller.lobby.InviteCommand;
	import com.sla.mvc.controller.lobby.AcceptCommand;
	import com.sla.mvc.controller.match.field.FindMinionPositionCommand;
	import com.sla.mvc.controller.match.scenario.action.attack.AttackAvailableCommand;
	import com.sla.mvc.controller.match.scenario.action.attack.AttackCompleteCommand;
	import com.sla.mvc.controller.match.scenario.action.attack.AttackMixinCommand;
	import com.sla.mvc.controller.match.scenario.action.attack.ClassicAttackCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.ActionPopupCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.request.RequestActivateActiveCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.request.RequestEffectSelectedCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.request.RequestTargetForAttackInitCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.request.RequestTargetForEffectInitCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.request.RequestTargetForSpellInitCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.SelectEffectCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.SelectTargetForAttackCommand;
	import com.sla.mvc.controller.match.field.StopFindMinionPositionCommand;
	import com.sla.mvc.controller.match.hand.requests.RequestPlayCardCommand;
	import com.sla.mvc.controller.match.hand.requests.RequestPlayCardCommand;
	import com.sla.mvc.controller.match.hand.StartDragCardCommand;
	import com.sla.mvc.controller.match.RequestMatchReadyCommand;
	import com.sla.mvc.controller.match.preflop.AddPreflopCardsToHand;
	import com.sla.mvc.controller.match.preflop.ChangeOpponentPreflopCommand;
	import com.sla.mvc.controller.match.preflop.ChangePreflopCommand;
	import com.sla.mvc.controller.match.preflop.MatchConnectionInitCommand;
	import com.sla.mvc.controller.match.preflop.OpponentPreflopClickCommand;
	import com.sla.mvc.controller.match.preflop.PreflopCommand;
	import com.sla.mvc.controller.match.preflop.request.RequestChangePreflopCommand;
	import com.sla.mvc.controller.match.preflop.request.RequestPreflopClickCommand;
	import com.sla.mvc.controller.match.preflop.request.RequestPreflopInitCommand;
	import com.sla.mvc.controller.match.preflop.WelcomeMatchAnimationCommand;
	import com.sla.mvc.controller.match.preflop.EndPreflopCommand;
	import com.sla.mvc.controller.match.scenario.action.attack.DamageCommand;
	import com.sla.mvc.controller.match.scenario.action.attack.PassiveAttackCommand;
	import com.sla.mvc.controller.match.scenario.action.attack.FreezeAttackCommand;
	import com.sla.mvc.controller.match.scenario.action.card.BackMinionToHandCommand;
	import com.sla.mvc.controller.match.scenario.action.card.PickCardCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.SelectTargetForEffectCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.SelectTargetForSpellCommand;
	import com.sla.mvc.controller.match.scenario.action.hand.RemoveCardCommand;
	import com.sla.mvc.controller.match.scenario.action.minion.GlowMinionsCommand;
	import com.sla.mvc.controller.match.scenario.action.minion.MinionHealthCommand;
	import com.sla.mvc.controller.match.scenario.action.minion.NewMinionCommand;
	import com.sla.mvc.controller.match.scenario.action.minion.PlayMinionCardCommand;
	import com.sla.mvc.controller.match.scenario.action.minion.RemoveMinionCommand;
	import com.sla.mvc.controller.match.scenario.action.minion.PlayMinionCardCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.request.RequestCancelSelectForAptCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.request.RequestTargetForAptitudeInitCommand;
	import com.sla.mvc.controller.match.scenario.action.drawing.SelectTargetForAptitudeCommand;
	import com.sla.mvc.controller.match.scenario.action.hand.GlowCardsCommand;
	import com.sla.mvc.controller.match.scenario.action.minion.SeveralMinionsHealthCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.AttackAndHealthCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.BlockActiveCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.ChangeAttackCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.DecreaseSpellCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.DestroyFreezeCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.DestroyShieldCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.FreezeCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.GlowMinionCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.IncreaseSpellCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.JerkCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.MassiveAttackCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.MassiveKillCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.ProvocationCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.ShieldCommand;
	import com.sla.mvc.controller.match.scenario.action.simple.ActivateWidgetCommand;

	import com.sla.mvc.controller.match.scenario.action.step.InitManaCommand;
	import com.sla.mvc.controller.match.scenario.action.step.StepCommand;
	import com.sla.mvc.controller.match.scenario.action.step.EndStepCommand;
	
	import com.sla.mvc.controller.match.scenario.exeption.ExceptionCommand;
	import com.sla.mvc.controller.match.scenario.ScenarioActionCommand;
	import com.sla.mvc.controller.match.scenario.ScenarioCommand;
	import com.sla.mvc.controller.match.startup.StartupMatchCommand;
	import com.sla.mvc.controller.match.startup.StartupMatchServiceCommand;
	
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
			commandMap.mapEvent(IntroEvent.SELECT_COLLECTION, CollectionSelectCommand);
			
			commandMap.mapEvent(IntroEvent.COMPLETE, ChangeStateCommand);
			
			// -- Collection --
			commandMap.mapEvent(CollectionEvent.STARTUP, StartupCollectionCommand);
			commandMap.mapEvent(CollectionEvent.REQUEST_COLLECTION, RequestCollectionCommand, CollectionEvent);
			commandMap.mapEvent(ApiServiceEvent.COLLECTION_INIT, CollectionInitCommand, ApiServiceEvent);
			commandMap.mapEvent(CollectionEvent.EDIT_DECK, RequestEditDeckCommand, CollectionEvent);
			commandMap.mapEvent(CollectionEvent.REMOVE_DECK, RequestRemoveDeckCommand, CollectionEvent);
			commandMap.mapEvent(CollectionEvent.PREVIEW_CARD, PreviewCollectionCardCommand, CollectionEvent);
			commandMap.mapEvent(ApiServiceEvent.EDIT_DECK_INIT, DeckInitCommand, ApiServiceEvent);
			commandMap.mapEvent(CollectionEvent.ADD_TO_DECK, AddToDeckCommand, CollectionEvent);
			
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
			commandMap.mapEvent(LobbyEvent.INVITE, InviteCommand, LobbyEvent);
			commandMap.mapEvent(LobbyServiceEvent.INVITE, DispatcherInviteCommand, LobbyServiceEvent);
			commandMap.mapEvent(LobbyServiceEvent.CONFIRM_SEND_INVITE, DispatcherConfirmInviteCommand , LobbyServiceEvent);
			commandMap.mapEvent(LobbyEvent.CANCEL, CancelCommand, LobbyEvent);
			commandMap.mapEvent(LobbyServiceEvent.CANCEL_INVITE, DispatcherCancelCommand, LobbyServiceEvent);
			commandMap.mapEvent(LobbyServiceEvent.CONFIRM_SEND_CANCEL, DispatcherConfirmCancelCommand, LobbyServiceEvent);
			commandMap.mapEvent(LobbyEvent.ACCEPT, AcceptCommand, LobbyEvent);
			commandMap.mapEvent(LobbyServiceEvent.ACCEPT_INVITATION, CloseLobbyCommand, LobbyServiceEvent);
			commandMap.mapEvent(LobbyEvent.CLOSE, ChangeStateCommand);
			commandMap.mapEvent(LobbyEvent.FORCE_CLOSE, ForceCloseLobbyCommand);
			
			//-- Match -- 
			commandMap.mapEvent(MatchEvent.STARTUP, StartupMatchCommand);
			commandMap.mapEvent(MatchEvent.STARTUP_COMPLETE, StartupMatchServiceCommand);
			
			//-- Match -- Preflop --
			commandMap.mapEvent(MatchServiceEvent.CONNECTION_INIT, MatchConnectionInitCommand, MatchServiceEvent);
			commandMap.mapEvent(MatchServiceEvent.PREFLOP_INIT, WelcomeMatchAnimationCommand);
			commandMap.mapEvent(SceneEvent.WELCOME_COMPLETE, PreflopCommand);
			commandMap.mapEvent(SceneEvent.CHANGE_PREFLOP, RequestChangePreflopCommand);
			commandMap.mapEvent(MatchServiceEvent.CHANGE_PREFLOP, ChangePreflopCommand, MatchServiceEvent);
			commandMap.mapEvent(SceneEvent.PREFLOP_INIT, RequestPreflopInitCommand); 
		    commandMap.mapEvent(MatchServiceEvent.END_PREFLOP, EndPreflopCommand, MatchServiceEvent);
			commandMap.mapEvent(SceneEvent.START_HAND_CARDS_INIT, AddPreflopCardsToHand, SceneEvent);
			commandMap.mapEvent(MatchServiceEvent.CHANGE_OPPONENT_PREFLOP, ChangeOpponentPreflopCommand, MatchServiceEvent);
			commandMap.mapEvent(SceneEvent.PREFLOP_CLICK, RequestPreflopClickCommand, SceneEvent);
	        commandMap.mapEvent(MatchServiceEvent.OPPONENT_PREFLOP_CLICK, OpponentPreflopClickCommand, MatchServiceEvent);
			commandMap.mapEvent(MatchEvent.READY, RequestMatchReadyCommand);
			
			//-- Match -- Scenario
			commandMap.mapEvent(MatchServiceEvent.SCENARIO, ScenarioCommand, MatchServiceEvent);
			commandMap.mapEvent(ScenarioEvent.ACTION, ScenarioActionCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.EXCEPTION, ExceptionCommand, ScenarioEvent);
			
			// -- Match -- Step
			commandMap.mapEvent(ScenarioEvent.STEP, StepCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.END_STEP, EndStepCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.INIT_MANA, InitManaCommand, ScenarioEvent);
			
			//-- Match -- Drawing
			commandMap.mapEvent(ScenarioEvent.PLAY_UNIT_CARD, PlayMinionCardCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.SELECT_TARGET_FOR_APTITUDE, SelectTargetForAptitudeCommand, ScenarioEvent);
			commandMap.mapEvent(SceneEvent.SELECT_FOR_APTITUDE_INIT, RequestTargetForAptitudeInitCommand, SceneEvent);
			commandMap.mapEvent(SceneEvent.CANCEL_SELECT_FOR_APTITUDE_UNIT, RequestCancelSelectForAptCommand);
			commandMap.mapEvent(SceneEvent.SELECT_FOR_ATTACK_INIT, RequestTargetForAttackInitCommand, SceneEvent);
			commandMap.mapEvent(HandEvent.SELECT_TARGET_FOR_SPELL, SelectTargetForSpellCommand, HandEvent);
			commandMap.mapEvent(SceneEvent.SELECT_FOR_SPELL_INIT, RequestTargetForSpellInitCommand, SceneEvent);
			commandMap.mapEvent(ScenarioEvent.SELECT_EFFECT, SelectEffectCommand, ScenarioEvent);
			commandMap.mapEvent(SceneEvent.EFFECT_SELECTED, RequestEffectSelectedCommand, SceneEvent);
			commandMap.mapEvent(ScenarioEvent.SELECT_TARGET_FOR_EFFECT, SelectTargetForEffectCommand, ScenarioEvent);
			commandMap.mapEvent(SceneEvent.TARGET_FOR_EFFECT_SELLECTED, RequestTargetForEffectInitCommand, SceneEvent);
			commandMap.mapEvent(SceneEvent.ACTION_POPUP, ActionPopupCommand, SceneEvent);
			commandMap.mapEvent(SceneEvent.ACTIVATE_ACTIVE, RequestActivateActiveCommand , SceneEvent);
			
			//-- Match -- Hand
			commandMap.mapEvent(HandEvent.START_DRAG, StartDragCardCommand, HandEvent);
			commandMap.mapEvent(HandEvent.PLAY_CARD, RequestPlayCardCommand, HandEvent);
			commandMap.mapEvent(ScenarioEvent.GLOW_CARDS, GlowCardsCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.REMOVE_CARD, RemoveCardCommand, ScenarioEvent);
			
			//-- MAtch -- Field
			commandMap.mapEvent(FieldEvent.FIND_MINION_POSITION, FindMinionPositionCommand);
			commandMap.mapEvent(FieldEvent.STOP_FIND_MINION_POSITION, StopFindMinionPositionCommand, FieldEvent);
			commandMap.mapEvent(SceneEvent.INIT_ATTACK_TARGET, SelectTargetForAttackCommand, SceneEvent);
			
			//-- Match -- Scenario -- Actions -- Card Actions 
			commandMap.mapEvent(ScenarioEvent.PICK_CARD, PickCardCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.BACK_CARD_TO_HAND, BackMinionToHandCommand, ScenarioEvent);
			
			//-- Match -- Scenario -- Actions -- Attack Actions 
			commandMap.mapEvent(ScenarioEvent.PASSIVE_ATTACK, PassiveAttackCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.FREEZE_ATTACK, FreezeAttackCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.DAMAGE, DamageCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.CLASSIC_ATTACK, ClassicAttackCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.ATTACK_COMPLETE, AttackCompleteCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.ATTACK_AVAILABLE, AttackAvailableCommand, ScenarioEvent);
			
			//-- Match -- Scenario -- Actions -- Minion
			commandMap.mapEvent(ScenarioEvent.REMOVE_MINION, RemoveMinionCommand, ScenarioEvent); 
			commandMap.mapEvent(ScenarioEvent.MINION_HEALTH, MinionHealthCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.SEVERAL_MINIONS_HEALTH, SeveralMinionsHealthCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.GLOW_MINIONS, GlowMinionsCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.DESTROY_FREEZE, DestroyFreezeCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.NEW_MINION, NewMinionCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.JERK, JerkCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.PROVOCATION, ProvocationCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.SHIELD, ShieldCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.DESTROY_SHIELD, DestroyShieldCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.CHANGE_ATTACK, ChangeAttackCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.INCREASE_SPELL, IncreaseSpellCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.DECREASE_SPELL, DecreaseSpellCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.FREEZE, FreezeCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.MASSIVE_ATTACK, MassiveAttackCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.MASSIVE_KILL, MassiveKillCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.ATTACK_MIXIN, AttackMixinCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.ATTACK_AND_HEALTH, AttackAndHealthCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.ACTIVATE_WIDGET, ActivateWidgetCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.BLOCK_ACTIVE, BlockActiveCommand, ScenarioEvent);
			commandMap.mapEvent(ScenarioEvent.GLOW_MINION, GlowMinionCommand, ScenarioEvent);
		
		}
		
	}

}