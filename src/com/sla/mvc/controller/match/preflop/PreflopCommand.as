package com.sla.mvc.controller.match.preflop 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.DeckModel;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.scene.PreflopPopup;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.mvc.view.scene.Scene;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreflopCommand extends StarlingCommand 
	{
		[Inject]
		public var preflop:PreflopPopup;
		
		[Inject]
		public var model:DeckModel;
		
		[Inject]
		public var scene:Scene;
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero;

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		[Inject]
		public var field:Field;
		
		[Inject]
		public var matchModel:MatchModel; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('PreflopCommand::execute()');
			stateModel.state = GameState.PREFLOP;
			
			scene.darkenHeroes();
			field.addHeroes(playerHero, opponentHero);
			
			playerHero.setStartHealth(matchModel.playerHeroHealth);
			opponentHero.setStartHealth(matchModel.opponentHeroHealth);
			playerHero.hideHealth();
			opponentHero.hideHealth();
			
			opponentHand.initFan();
			opponentHand.x = contextView.stage.stageWidth / 2 - 5;
			opponentHand.y = -35;
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
			
			opponentHand.preflopCards(model.getOpponentCards());
						
			preflop.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(preflop);
			preflop.previewCards(model.getPlayerCards());
		}		
	}

}