package com.sla.mvc.controller.bootstrap 
{
	import com.indico.fan.Fan;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.mvc.view.collection.CraftWidget;
	import com.sla.mvc.view.field.EndMatchPopup;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.Hero;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.preloader.Preloader;
	import com.sla.mvc.view.scene.PreflopPopup;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.core.IInjector;
	import com.sla.mvc.view.decklist.DeckList;
	import com.sla.mvc.view.intro.Intro;
	import com.sla.mvc.view.lobby.Lobby;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapClasses 
	{
		
		public function BootstrapClasses(injector:IInjector)  
		{
			injector.mapSingleton(Intro);
			injector.mapSingleton(DeckList);
			injector.mapSingleton(Lobby);
			injector.mapSingleton(Field);
			injector.mapSingleton(Scene);
			injector.mapSingleton(PreflopPopup);
			injector.mapSingleton(PlayerHand);
			injector.mapSingleton(OpponentHand);
			injector.mapSingleton(Collection);
			injector.mapSingleton(Preloader);
			injector.mapSingleton(CraftWidget);
			injector.mapSingleton(EndMatchPopup);
			injector.mapSingleton(AbilityBrowser);
						
			var playerHero:Hero = new Hero();
			playerHero.isEnemy = false;
			injector.mapValue(IHero, playerHero, 'playerHero');

			var opponentHero:Hero = new Hero(); 
			opponentHero.isEnemy = true;
			injector.mapValue(IHero, opponentHero, 'opponentHero');
		}
		
	}

}