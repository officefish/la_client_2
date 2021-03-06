/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
import com.la.mvc.view.achieves.AchieveBrowser;
import com.la.mvc.view.achieves.AchieveSlot;
import com.la.mvc.view.achieves.CraftAchieveWidget;
import com.la.mvc.view.card.AchieveCard;
import com.la.mvc.view.card.AchieveCraftCard;
import com.la.mvc.view.card.CardSensor;
import com.la.mvc.view.card.CollectionCard;
import com.la.mvc.view.collection.CraftWidget;
import com.la.mvc.view.collection.DeckItemSlot;
import com.la.mvc.view.collection.DeckSlot;
import com.la.mvc.view.field.deck.FieldDeckSlot;
import com.la.mvc.view.field.FieldAchieveSlot;
import com.la.mvc.view.field.IToken;
import com.la.mvc.view.field.StepButton;
import com.la.mvc.view.collection.ICollection;
import com.la.mvc.view.mediator.AchieveCardMediator;
import com.la.mvc.view.mediator.AchieveCraftCardMediator;
import com.la.mvc.view.mediator.AchieveMediator;
import com.la.mvc.view.mediator.AchieveSlotMediator;
import com.la.mvc.view.mediator.CardSensorMediator;
import com.la.mvc.view.mediator.CraftAchieveWidgetMediator;
import com.la.mvc.view.mediator.CraftMediator;
import com.la.mvc.view.mediator.FieldAchieveSlotMediator;
import com.la.mvc.view.mediator.FieldDeckSlotMediator;

import com.la.mvc.view.IIntro;
import com.la.mvc.view.card.PreflopCard;
import com.la.mvc.view.deck.DeckList;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.IField;
import com.la.mvc.view.lobby.Lobby;
import com.la.mvc.view.mediator.CollectionCardMediator;
import com.la.mvc.view.mediator.CollectionMediator;
import com.la.mvc.view.mediator.DeckListMediator;
import com.la.mvc.view.mediator.DeckItemSlotMediator;
import com.la.mvc.view.mediator.DeckSlotMediator;
import com.la.mvc.view.mediator.FieldMediator;
import com.la.mvc.view.mediator.IntroMediator;
import com.la.mvc.view.mediator.LobbyMediator;
import com.la.mvc.view.mediator.OpponentDeckMediator;
import com.la.mvc.view.mediator.PlayerDeckMediator;
import com.la.mvc.view.mediator.PreflopCardMediator;
import com.la.mvc.view.mediator.SceneMediator;
import com.la.mvc.view.mediator.StepButtonMediator;
import com.la.mvc.view.mediator.TokenMediator;

import com.la.mvc.view.scene.IScene;

import org.robotlegs.core.IMediatorMap;

public class BootstrapView {
    public function BootstrapView(mediatorMap:IMediatorMap) {
        mediatorMap.mapView(IIntro, IntroMediator);
        mediatorMap.mapView(IField, FieldMediator);
        mediatorMap.mapView(IScene, SceneMediator);
        mediatorMap.mapView(PlayerDeck, PlayerDeckMediator);
		mediatorMap.mapView(EnemyDeck, OpponentDeckMediator);
        mediatorMap.mapView(Lobby, LobbyMediator);
        mediatorMap.mapView(DeckList, DeckListMediator);
        mediatorMap.mapView(PreflopCard, PreflopCardMediator);
		mediatorMap.mapView(StepButton, StepButtonMediator);
		mediatorMap.mapView(IToken, TokenMediator);
		mediatorMap.mapView(CollectionCard, CollectionCardMediator);
		mediatorMap.mapView(AchieveCard, AchieveCardMediator);
		mediatorMap.mapView(AchieveSlot, AchieveSlotMediator);
		mediatorMap.mapView(ICollection, CollectionMediator);
		mediatorMap.mapView(DeckItemSlot, DeckItemSlotMediator);
		mediatorMap.mapView(DeckSlot, DeckSlotMediator);
		mediatorMap.mapView(CraftWidget, CraftMediator);
		mediatorMap.mapView(CardSensor, CardSensorMediator);
		mediatorMap.mapView(AchieveBrowser, AchieveMediator);
		mediatorMap.mapView(AchieveCraftCard, AchieveCraftCardMediator);
		mediatorMap.mapView(CraftAchieveWidget, CraftAchieveWidgetMediator);
		mediatorMap.mapView(FieldAchieveSlot, FieldAchieveSlotMediator);
		mediatorMap.mapView(FieldDeckSlot, FieldDeckSlotMediator);
		



        //mediatorMap.mapView(ICollection, CollectionView);
    }
}
}
