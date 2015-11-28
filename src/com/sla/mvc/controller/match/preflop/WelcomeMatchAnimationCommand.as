package com.sla.mvc.controller.match.preflop 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class WelcomeMatchAnimationCommand extends StarlingCommand 
	{
		[Inject (name = 'playerHero')]
		public var playerHero:IHero;

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		[Inject]
		public var matchModel:MatchModel; 
		
		[Inject]
		public var scene:Scene;
		
		[Inject]
		public var field:Field; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('WelcomeMatchAnimationCommand::execute()');
			
			playerHero.setType (matchModel.playerHero);
			opponentHero.setType (matchModel.opponentHero);
			
			playerHero.setHealth(matchModel.playerHeroHealth);
			playerHero.setMaxHealth (matchModel.playerHeroHealth);
        
			opponentHero.setHealth(matchModel.opponentHeroHealth);
			opponentHero.setMaxHealth (matchModel.opponentHeroHealth);

			playerHero.hideHealth();
			opponentHero.hideHealth();
			
			scene.playerHero = playerHero.asDO();
			scene.opponentHero = opponentHero.asDO();
			
			field.initAbilities(matchModel.playerAbilities, matchModel.opponentAbilities);

			
			var positions:Object = scene.welcomeAnimation();
		}		
	}

}