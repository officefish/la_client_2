package com.sla.mvc.controller.match 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.IntroEvent;
	import com.sla.mvc.model.DeckModel;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.service.MatchService;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.Scene;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CloseMatchCommand extends StarlingCommand 
	{
		
		[Inject]
		public var field:Field; 
		
		[Inject]
		public var scene:Scene; 
		
		[Inject]
		public var playerHand:PlayerHand;

		[Inject]
		public var opponentHand:OpponentHand;
		
		[Inject]
		public var service:MatchService; 
		
		[Inject]
		public var deckModel:DeckModel; 
		
		[Inject]
		public var matchModel:MatchModel; 
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero; 

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
				
		override public function execute():void 
		{
			MonsterDebugger.log ('CloseMatchCommand::execute');
			service.close();
			
			// чистим за предыдущим матчем
			// some code ...
			contextView.removeChild(field);
			contextView.removeChild(scene);
			contextView.removeChild(playerHand);
			contextView.removeChild(opponentHand);
			
			field.clear();
			//scene.clear();
			playerHand.clear();
			opponentHand.clear();
			deckModel.clear();
			matchModel.clear();
			matchModel.block = false;
			playerHero.clear();
			opponentHero.clear();
			
			stateModel.state = GameState.DECK_LIST; 
			dispatch (new IntroEvent(IntroEvent.COMPLETE)); 
			
			
		}		
	}

}