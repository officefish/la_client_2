/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {

<<<<<<< HEAD
import com.la.mvc.view.collection.Collection;
import com.la.mvc.view.field.StepButton;
import com.la.mvc.view.collection.ICollection;
=======
import com.la.mvc.view.ICollection;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import com.la.mvc.view.IGame;
import com.la.mvc.view.IIntro;
import com.la.mvc.view.deck.DeckList;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.deck.PlayerDeck;
import com.la.mvc.view.field.Field;
import com.la.mvc.view.field.IField;
<<<<<<< HEAD
import com.la.mvc.view.intro.Intro;
import com.la.mvc.view.lobby.Lobby;
import com.la.mvc.view.scene.IScene;
import com.la.mvc.view.scene.Scene;

//import com.ps.collection.view.CollectionView;
//import com.ps.intro.Intro;

import com.la.mvc.view.field.Hero;
import com.la.mvc.view.field.IHero;
import com.la.mvc.view.debug.Console;
=======
import com.la.mvc.view.lobby.Lobby;
import com.la.mvc.view.scene.IScene;
import com.la.mvc.view.scene.Scene;
import com.ps.collection.view.CollectionView;
import com.ps.game.Game;
import com.ps.intro.Intro;
import com.la.mvc.view.field.Hero;
import com.la.mvc.view.field.IHero;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import org.robotlegs.core.IInjector;

public class BootstrapClasses {
    public function BootstrapClasses(injector:IInjector) {
<<<<<<< HEAD
        
		injector.mapClass(IIntro, Intro);
        injector.mapSingletonOf(ICollection, Collection, 'collection');
        
		injector.mapSingletonOf(IScene, Scene, 'scene');
=======
        injector.mapClass(IIntro, Intro);
        injector.mapSingletonOf(IGame, Game, 'game');
        injector.mapSingletonOf(ICollection, CollectionView, 'collection');
        injector.mapSingletonOf(IScene, Scene, 'scene');
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        injector.mapSingletonOf(IField, Field, 'field');

        var playerHero:Hero = new Hero();
        playerHero.isEnemy = false;
        injector.mapValue(IHero, playerHero, 'playerHero');

        var opponentHero:Hero = new Hero();
        opponentHero.isEnemy = true;
        injector.mapValue(IHero, opponentHero, 'opponentHero');

        injector.mapSingletonOf(PlayerDeck, PlayerDeck, 'playerDeck');
        injector.mapSingletonOf(EnemyDeck, EnemyDeck, 'enemyDeck');
        injector.mapSingletonOf(Lobby, Lobby, 'lobby');

        injector.mapSingletonOf(DeckList, DeckList, 'deckList');
<<<<<<< HEAD
		injector.mapSingletonOf(Console, Console, 'appConsole');
		injector.mapClass (StepButton, StepButton);
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }
}
}
