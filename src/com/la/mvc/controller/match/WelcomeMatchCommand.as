/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchEvent;
import com.la.mvc.model.MatchModel;
import com.la.mvc.view.field.IField;
import com.la.mvc.view.field.IHero;
import com.la.mvc.view.scene.IScene;

import org.robotlegs.mvcs.Command;

public class WelcomeMatchCommand extends Command {

    [Inject (name = 'playerHero')]
    public var playerHero:IHero;

    [Inject (name = 'opponentHero')]
    public var opponentHero:IHero;

    [Inject (name='field')]
    public var field:IField;

    [Inject (name='scene')]
    public var scene:IScene;

    [Inject (name='matchModel')]
    public var matchModel:MatchModel;

    override public function execute():void {

        playerHero.setType (matchModel.playerHero);
        opponentHero.setType (matchModel.opponentHero);
<<<<<<< HEAD
		opponentHero.isEnemy = true;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

        playerHero.setHealth(matchModel.playerHeroHealth);
        opponentHero.setHealth(matchModel.opponentHeroHealth);

        playerHero.hideHealth();
        opponentHero.hideHealth();

        scene.setPlayerHero(playerHero);
        scene.setOpponentHero(opponentHero);
        scene.welcomeAnimation();
    }
}
}