/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.controller.match {
import com.la.event.MatchServiceEvent;
import com.la.mvc.model.CollectionModel;
import com.la.mvc.model.DeckModel;
import com.la.mvc.model.MatchModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.EnemyDeck;
import com.la.mvc.view.field.IField;
import com.la.mvc.view.IGame;
import com.la.mvc.view.scene.IScene;
<<<<<<< HEAD
import com.la.mvc.model.CardData;
=======
import com.ps.cards.CardData;

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import org.robotlegs.mvcs.Command;

public class MatchConnectionInitCommand extends Command {

    [Inject (name='deckModel')]
    public var model:DeckModel;

    [Inject]
    public var event:MatchServiceEvent;

    [Inject (name='matchModel')]
    public var matchModel:MatchModel;

    [Inject (name='scene')]
    public var scene:IScene;

    override public function execute():void {

        var cardDatas:Vector.<CardData> = getCardDataVector(event.getData().preflop);
        model.addPlayerCards (cardDatas);

<<<<<<< HEAD
        cardDatas = getCardDataVector(event.getData().opponent_preflop);
=======
        var cardDatas:Vector.<CardData> = getCardDataVector(event.getData().opponent_preflop);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        model.addOpponentCards (cardDatas);

        matchModel.mode = int (event.getData().mode);

        matchModel.playerHero = event.getData().hero;
        matchModel.opponentHero = event.getData().opponent_hero;

        matchModel.playerHeroHealth = event.getData().health;
        matchModel.opponentHeroHealth = event.getData().opponent_health;
<<<<<<< HEAD
		
		matchModel.whiteFlag = event.getData().white;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

        dispatch(new MatchServiceEvent(MatchServiceEvent.PREFLOP_INIT, {}))

    }

    private function getCardDataVector (data:Array) :Vector.<CardData> {
        var vector:Vector.<CardData> = new Vector.<CardData>();
        for (var i:int = 0; i < data.length; i ++) {
<<<<<<< HEAD
            var cardData:CardData = CardData.converToData (data[i]);
=======

            var attack:int = data[i].attack;
            var health:int = data[i].health;
            var price:int = data[i].price;
            var title:String = data[i].title;
            var description:String = data[i].description;

            var cardData:CardData = new CardData(attack, health, price);

            cardData.id = data[i].id;

            cardData.setTitle(title);
            cardData.setDescription(description);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
            vector.push(cardData)
        }

        return vector;
    }
}
}