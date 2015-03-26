/**
 * Created by root on 11/11/14.
 */
package com.la.mvc.view.deck {
import com.greensock.TimelineLite;
import com.greensock.TweenLite;
import com.greensock.TweenLite;
import com.greensock.easing.Ease;
import com.greensock.easing.Expo;
import com.la.event.ScenarioEvent;
import com.la.event.SceneEvent;
import com.la.mvc.view.card.Card;
import com.la.mvc.model.CardData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;

public class EnemyDeck extends Deck {

    private var actualCard:Card;
    private var animationCof:int = 0;

    public function EnemyDeck() {
        this.cardsStack = new Sprite();
        addChildAt(cardsStack, 0);
    }

    override public function addCards(cards:Vector.<CardData>, animation:Boolean = false):Vector.<Card> {
        var card:Card;
        var vector:Vector.<Card> = new Vector.<Card>();
        for (var i:int = 0; i < cards.length; i++) {
            card = addCard(cards[i], false);
            vector.push(card);
        }

        sortCollodion(0, false);
        var collodionPosition:Point = centerizeCollodion (false);

        if (animation) {
            animateCards (vector, collodionPosition);
        }

        return vector;
    }

    private function animateCards (vector:Vector.<Card>, collodionPosition:Point) :void {
        sortCollodion(0, false);
        animationCof = 0;

        for (var i:int = 0; i < vector.length; i ++) {

            var card:Card = vector[i];
            var shirt:DisplayObject = card.getShirt();
            shirt.y = 200;
            shirt.x = stageWidth + 100;

            scene.placeCard(shirt);

            var cardPosition:Point = new Point(card.x, card.y);
            cardPosition.x += collodionPosition.x;
            cardPosition.y += collodionPosition.y;

            card.visible = false;
            animationCof ++;

            TweenLite.to (shirt, 0.7, {
                x:cardPosition.x,
                y:cardPosition.y,
                scaleX:0.675,
                scaleY:0.67,
                ease:Expo.easeOut,
                onComplete:onAddCardComplete,
                onCompleteParams:[card]

            });

        }
    }


    private function onAddCardComplete (card:Card) :void {

        card.visible = true;

        var shirt:Sprite = card.getShirt ();
        shirt.scaleX = 1.0;
        shirt.scaleY = 1.0;

        animationCof --;
        if (!animationCof) {
            scene.endPlaceCard();
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
		}
        //dispatchEvent (new Event (COMPLETE_PLACE_CARD));
    }

    override public function addCard (cardData:CardData, animation:Boolean = true) :Card {
        trace ('addCard');
		
		var card:Card = new Card (cardData);
        card.graphics.clear();
        while (card.numChildren) card.removeChildAt (0);
        card.addChild (card.getSmallShirt());
        cardsStack.addChild (card);
		
		sortCollodion(0, false);
        var collodionPosition:Point = centerizeCollodion (false);
        if (animation) {
            var vector:Vector.<Card> = new Vector.<Card>();
            vector.push(card);
            animateCards (vector, collodionPosition);
        } 
		return card;

    }
	
	public function changeCard (card:Card, cardData:CardData) :Card {
						
			var newCard:Card = new Card (cardData);
			var position:Point = new Point (card.x, card.y);
			
			newCard.graphics.clear();
			while (newCard.numChildren) newCard.removeChildAt (0);
			newCard.addChild (newCard.getSmallShirt());
			
			var index:int = cardsStack.getChildIndex (card);
			cardsStack.addChildAt (newCard, index);
			
			newCard.x = position.x;
			newCard.y = position.y;
			
			return newCard;
	}
	
	public function getCard (index:int) :Card {
		return cardsStack.getChildAt(index) as Card;
	}
	
	public function removeCardAt (index:int) :void {
		var card:Card = cardsStack.getChildAt(index) as Card;
		if (card) {
			cardsStack.removeChildAt (index);
			sortCollodion();
			centerizeCollodion ();
		}
	}

	override public function sort(endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false):void 
	{
		sortCollodion(0, false);
		centerizeCollodion (false);
		if (sygnalFlag) {
			dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));		
		}
	}
	
	public function getCardsCount() :int {
		return cardsStack.numChildren;
	}



    private function sortCollodion (index:int = 0, animation:Boolean = true) :Point {
        var centerX:int = stageWidth / 2;
        var yPosition:int = 0 - (Card.CARD_HEIGHT - 30);
        var shift:int = 90 - (cardsStack.numChildren * 5);

        var position:Point = new Point ();
        for (var i:int = 0; i < cardsStack.numChildren; i ++) {
            var shirt:Sprite = cardsStack.getChildAt (i) as Sprite;
            shirt.x = shift * i;
            if (index == i) {
                position.x = shift * i;
            }
            //TweenLite.to (shirt, 0.4, { x:shift * i } );
            shirt.y = yPosition;
            position.y = yPosition
        }

        return position;
    }


    private function centerizeCollodion (animation:Boolean = true) :Point {
        var cardStackX:int = (stageWidth - cardsStack.width) / 2;
        if (animation) {
            TweenLite.to (cardsStack, 0.4, { x:cardStackX } );
        } else {
            cardsStack.x = cardStackX;
        }

        return new Point (cardStackX, cardsStack.y);
    }

    public function click (index:int, select:Boolean) :void {
        var card:DisplayObject = cardsStack.getChildAt(index) as DisplayObject;
        var yPosition:int;
        if (select) {
            yPosition = 0 - (Card.CARD_HEIGHT - 30);
        } else {
            yPosition = 0 - (Card.CARD_HEIGHT - 45);
        }

        TweenLite.to (card, 0.5, {y:yPosition, ease:Expo.easeOut});
    }

    public function changeCards (data:Array) :void {
        for (var i:int = 0; i < data.length; i ++) {
            var index:int = data[i].index;
            var card:DisplayObject = cardsStack.getChildAt(index) as DisplayObject;
            var position:Point = new Point (card.x, 0 - (Card.CARD_HEIGHT - 30));
            var timeline:TimelineLite = new TimelineLite();
            timeline.append(TweenLite.to(card, 1.0, {x:this.stageWidth, y:300, ease:Expo.easeIn}));
            timeline.append(TweenLite.to(card, 1.0, {x:position.x, y:position.y, ease:Expo.easeOut}));

        }
    }
}
}
