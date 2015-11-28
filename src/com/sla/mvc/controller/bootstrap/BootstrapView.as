package com.sla.mvc.controller.bootstrap 
{
	
	import com.sla.mvc.view.ability.AbilityBrowser;
	import com.sla.mvc.view.ability.AbilityCard;
	import com.sla.mvc.view.ability.AbilityCraftCard;
	import com.sla.mvc.view.ability.AbilitySlot;
	import com.sla.mvc.view.card.CardSensor;
	import com.sla.mvc.view.card.CollectionCard;
	import com.sla.mvc.view.card.PreflopCard;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.mvc.view.collection.CraftWidget;
	import com.sla.mvc.view.collection.deck.DeckSlot;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.FieldAbilitySlot;
	import com.sla.mvc.view.field.minion.hero.Hero;
	import com.sla.mvc.view.field.minion.Minion;
	import com.sla.mvc.view.lobby.Lobby;
	import com.sla.mvc.view.mediator.AbilityCardMediator;
	import com.sla.mvc.view.mediator.AbilityCraftCardMediator;
	import com.sla.mvc.view.mediator.AbilityMediator;
	import com.sla.mvc.view.mediator.AbilitySlotMediator;
	import com.sla.mvc.view.mediator.CardSensorMediator;
	import com.sla.mvc.view.mediator.CollectionCardMediator;
	import com.sla.mvc.view.mediator.CollectionMediator;
	import com.sla.mvc.view.mediator.CraftWidgetMediator;
	import com.sla.mvc.view.mediator.DeckSlotMediator;
	import com.sla.mvc.view.mediator.FieldAbilitySlotMediator;
	import com.sla.mvc.view.mediator.FieldMediator;
	import com.sla.mvc.view.mediator.HeroMediator;
	import com.sla.mvc.view.mediator.LobbyMediator;
	import com.sla.mvc.view.mediator.MinionMediator;
	import com.sla.mvc.view.mediator.PreflopCardMediator;
	import com.sla.mvc.view.mediator.PreflopPopupMediator;
	import com.sla.mvc.view.mediator.SceneMediator;
	import com.sla.mvc.view.scene.PreflopPopup;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.core.IStarlingMediatorMap;
	
	import com.sla.mvc.view.intro.Intro;
	import com.sla.mvc.view.mediator.IntroMediator;
	import com.sla.mvc.view.decklist.DeckList;
	import com.sla.mvc.view.mediator.DeckListMediator;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapView 
	{
		
		public function BootstrapView(mediatorMap:IStarlingMediatorMap)  
		{
			mediatorMap.mapView(Intro, IntroMediator);
			mediatorMap.mapView(DeckList, DeckListMediator); 
			mediatorMap.mapView(Lobby, LobbyMediator);
			mediatorMap.mapView(Scene, SceneMediator);
			mediatorMap.mapView(PreflopCard, PreflopCardMediator);
			mediatorMap.mapView(PreflopPopup, PreflopPopupMediator);
			mediatorMap.mapView(CardSensor, CardSensorMediator);
			mediatorMap.mapView(Field, FieldMediator);
			mediatorMap.mapView(Minion, MinionMediator);
			mediatorMap.mapView(DeckSlot, DeckSlotMediator);
			mediatorMap.mapView(CollectionCard, CollectionCardMediator);
			mediatorMap.mapView(Collection, CollectionMediator);
			mediatorMap.mapView(CraftWidget, CraftWidgetMediator);
			mediatorMap.mapView(Hero, HeroMediator);
			mediatorMap.mapView(AbilityBrowser, AbilityMediator);
			mediatorMap.mapView(AbilitySlot, AbilitySlotMediator);
			mediatorMap.mapView(AbilityCard, AbilityCardMediator);
			mediatorMap.mapView(AbilityCraftCard, AbilityCraftCardMediator);
			mediatorMap.mapView(FieldAbilitySlot, FieldAbilitySlotMediator);
		}
		
	}

}