package com.sla.mvc.controller.bootstrap 
{
	import com.sla.event.ApiServiceEvent;
	import com.sla.event.DeckEvent;
	import com.sla.event.LAContextEvent;
	import com.sla.mvc.controller.deck.CloseDeckListCommand;
	import com.sla.mvc.controller.deck.IntroDecklistInitCommand;
	import com.sla.mvc.controller.deck.request.RequestDeckListCommand;
	import com.sla.mvc.controller.deck.StartupDeckListCommand;
	
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
			/* All initialisation realise in bootstrap classes but here we can configure some special things
			 * for example add some flashvars to model, configure service links, starling settings and so on 
			 */
			// init model
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitModelCommand, ContextEvent);
			// init services
			commandMap.mapEvent(LAContextEvent.MODEL_INIT, InitServiceCommand, LAContextEvent);
			// init view
			commandMap.mapEvent(LAContextEvent.SERVICE_INIT, InitViewCommand, LAContextEvent);
			
			commandMap.mapEvent(LAContextEvent.VIEW_INIT, StartupIntroCommand);
			
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
			commandMap.mapEvent(DeckEvent.STARTUP, StartupDeckListCommand);
			commandMap.mapEvent(DeckEvent.REQUEST_DECKLIST, RequestDeckListCommand);
			commandMap.mapEvent(ApiServiceEvent.INTRO_DECKLIST_INIT, IntroDecklistInitCommand, ApiServiceEvent);
			commandMap.mapEvent(DeckEvent.CLOSE, CloseDeckListCommand);
			
		}
		
	}

}