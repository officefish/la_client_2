package com.la.mvc.controller.match 
{

	import com.la.event.DeckEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.service.MatchService;
	import com.la.mvc.view.deck.EnemyDeck;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IHero;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.debug.Console;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EndMatchCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='field')]
		public var field:IField; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck;

		[Inject (name='enemyDeck')]
		public var enemyDeck:EnemyDeck;
		
		[Inject]
		public var service:MatchService; 
		
		[Inject (name='deckModel')]
		public var model:DeckModel; 
		
		[Inject (name = 'matchModel')]
		public var matchModel:MatchModel; 
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero;

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero;
		
		
		
		override public function execute():void 
		{
			console.debug('EndMatchCommand::execute');
			
			service.close();
			
			// чистим за предыдущим матчем
			// some code ...
			scene.lighten (false);
			field.stopBlur();
			contextView.removeChild(field as DisplayObject);
			contextView.removeChild(scene as DisplayObject);
			contextView.removeChild(playerDeck as DisplayObject);
			contextView.removeChild(enemyDeck as DisplayObject);
			
			field.clear();
			scene.clear();
			playerDeck.clear();
			enemyDeck.clear();
			model.clear();
			matchModel.clear();
			playerHero.clear();
			opponentHero.clear();
						
			dispatch(new DeckEvent(DeckEvent.STARTUP_DECK_LIST, {})); 
			
		}		
	}

}