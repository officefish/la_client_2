/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.deck {
import com.greensock.TimelineLite;
import com.greensock.easing.Expo;
<<<<<<< HEAD
import com.la.event.ConsoleEvent;
import com.la.event.DeckEvent;
import com.la.event.ScenarioEvent;
import com.la.mvc.view.card.Card;
import com.la.mvc.view.card.CardSensor;
import com.la.mvc.model.CardData;
=======
import com.la.event.DeckEvent;
import com.la.mvc.view.card.Card;
import com.la.mvc.view.card.CardSensor;
import com.ps.cards.CardData;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Point;
<<<<<<< HEAD
import com.demonsters.debugger.MonsterDebugger;

=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

public class PlayerDeck extends Deck {

    private var mirrorStack:Sprite;
    private var sensorStack:Sprite;

    private var actualCard:Card;
    private var mirror:Sprite;

    private var blockFlag:Boolean = true;
    private var dragMode:Boolean = false;

    private var playDistance:int;
<<<<<<< HEAD
	
	private var tokenLimit:int = 7;
	private var tokenLimitFlag:Boolean = false;
	
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2


    public function PlayerDeck() {
        super ();
<<<<<<< HEAD
		
		//dispatchEvent (new ConsoleEvent(ConsoleEvent.DEBUG, 'playDeck constructor'));
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

        mirrorStack = new Sprite ();
        addChild (mirrorStack);

        sensorStack = new Sprite ();
        addChild (sensorStack);
    }

    override public function addCards (cards:Vector.<CardData>, quick:Boolean = false) :Vector.<Card> {
        var card:Card;
        var vector:Vector.<Card> = new Vector.<Card>();
        for (var i:int = 0; i < cards.length; i++) {
            card = addCard(cards[i], quick);
            vector.push(card);
        }

        return vector;
        //dispatchEvent(new DeckEvent(DeckEvent.CARDS_ADDED, {cards:vector}))

    }

    override public function addCard (cardData:CardData, animation:Boolean = false) :Card {
            var card:Card = new Card (cardData);

            //card.setHero(field.getPlayerHero())

            cardsStack.addChildAt (card, cardsStack.numChildren);
            var sensor:CardSensor = card.getSensor();
            sensorStack.addChild (sensor);
            sortCollodion ();

            if (animation) {
                var cardMirrow:DisplayObject = card.getMirrorBitmap ();
                cardMirrow.y = 300;
                cardMirrow.x = stageWidth + 100;
                scene.placeCard(cardMirrow);

                var cardPosition:Point = new Point (card.x, card.y);
                cardPosition = card.parent.localToGlobal (cardPosition);

                card.visible = false;
;
                var timeline:TimelineLite = new TimelineLite ({
                    onComplete:onAddCardComplete,
                    onCompleteParams:[card]
                });
                timeline.to (cardMirrow, 1.0, { x:500, y:200, ease:Expo.easeOut} );
                timeline.to (cardMirrow, 0.5, { x:cardPosition.x, y:cardPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeInOut});

            }

            sensor.addEventListener (MouseEvent.MOUSE_OVER, onCardMouseOver);
            sensor.addEventListener (MouseEvent.MOUSE_OUT, onCardMouseOut);
            sensor.addEventListener (MouseEvent.MOUSE_DOWN, onCardMouseDown);
            sensor.addEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);


            return card;


        }

        private function onAddCardComplete (card:Card) :void {
            scene.endPlaceCard();
            card.visible = true;
<<<<<<< HEAD
			dispatchEvent(new ScenarioEvent(ScenarioEvent.ACTION));
=======
            dispatchEvent(new DeckEvent(DeckEvent.PLAYER_CARD_ADDED, {}));
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        }

        private function sortCollodion () :void {
            var centerX:int = stageWidth / 2;
            var yPosition:int = stageHeight - 50;
            var shift:int = 90 - (cardsStack.numChildren * 5);

            for (var i:int = 0; i < cardsStack.numChildren; i ++) {
                var card:Card = cardsStack.getChildAt (i) as Card;
                card.x = card.getSensor().x  = shift * i;
                card.y = card.getSensor().y = yPosition;
            }

            cardsStack.x = sensorStack.x = (stageWidth - cardsStack.width) / 2
        }

        override public function get shiftX () :int {
            return cardsStack.x;
        }

        override public function block () :void {
            blockFlag = true;
        }

<<<<<<< HEAD
        override public function unblock(endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
            blockFlag = false;
			dragMode = false;
			if (sygnalFlag) {
				dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));		
			}
        }
		
		override public function sort(endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false):void 
		{
			sortCollodion();
			
			if (sygnalFlag) {
				dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));		
			}
		}

        public function glowAvailableCards (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
            if (tokenLimitFlag) {
				dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));
				return;
			}
			
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
                var card:Card = cardsStack.getChildAt (i) as Card;
=======
        override public function unblock() :void {
            blockFlag = false;
        }

        public function glowAvailableCards () :void {
            for (var i:int = 0; i < cardsStack.numChildren; i ++) {
                var card:Card = cardsStack.getChildAt (i) as Card;
                trace(card.getPrice())
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
                if (card.getPrice() <= price) {
                //if (card.getPrice() <= playerPrice && numChildren < 7) {
                    card.filters = [new GlowFilter(0x00FFFF)]
                } else {
                    card.filters = null;
                }
            }
<<<<<<< HEAD
			if (sygnalFlag) {
				dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));		
			}
        }
		
		public function stopGlowCards () :void {
            for (var i:int = 0; i < cardsStack.numChildren; i ++) {
                var card:Card = cardsStack.getChildAt (i) as Card;
                card.filters = null;
            }
        }


	public function setTokenRowLength (length:int) :void {
		if (length >= tokenLimit) {
			tokenLimitFlag = true;
		} else {
			tokenLimitFlag = false;
		}
	}
		
=======
        }



>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    private function onCardMouseOver (event:MouseEvent) :void {

        if (dragMode) {
            return;
        }
        /*
        TrajectoryContainer.getInstance().endTokenPreview();
        */
        var cardSensor:CardSensor;
        cardSensor = event.target as CardSensor;

        var card:Card = cardSensor.getCard ();
        card.visible = false;

        actualCard = card;
        //actualCard.checkSpell ();

        var mirrorCard:Sprite = card.getMirror ();

        mirrorStack.addChild (mirrorCard);
        mirrorCard.x = event.target.x + event.target.parent.x - 15;
        mirrorCard.y = stageHeight - (mirrorCard.height + 20);
        mirror = mirrorCard;
    }

    private function onCardMouseOut (event:MouseEvent) :void {

         if (dragMode) {
         return;
         }

         while (mirrorStack.numChildren) {
            mirrorStack.removeChildAt (mirrorStack.numChildren - 1);
         }
         actualCard.visible = true;

    }

    private function onCardMouseDown (event:MouseEvent) :void {
        if (blockFlag) {
            return;
        }

        var cardPrice:int = actualCard.getPrice ();
        if (cardPrice > price) {
            return;
        }

<<<<<<< HEAD
        if (tokenLimitFlag) {
			return;
		}
		
=======
        /*
        var numChildren:int = field.getPlayerRowNumChildren ();
        if (numChildren >= 7) {
            return;
        }
        */

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        dragMode = true;
        mirror.startDrag ();

        //if (actualCard.getType() == CardData.UNIT) {
            dispatchEvent(new DeckEvent(DeckEvent.FIND_POSITION, {}));
        //}


        stage.addEventListener (MouseEvent.MOUSE_UP, onMirrowCardUp);
    }

    private function onMirrowCardUp (event:MouseEvent) :void {

<<<<<<< HEAD
		mirror.stopDrag();
=======
        mirror.stopDrag();
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

        //if (actualCard.getType() == CardData.UNIT) {
            dispatchEvent(new DeckEvent(DeckEvent.STOP_FIND_POSITION, {}));
        //}


        stage.removeEventListener (MouseEvent.MOUSE_UP, onMirrowCardUp);

        if (mouseY < playDistance) {

            var sensor:CardSensor = actualCard.getSensor();
            sensor.removeEventListener (MouseEvent.MOUSE_OVER, onCardMouseOver)
            sensor.removeEventListener (MouseEvent.MOUSE_OUT, onCardMouseOut);
            sensor.removeEventListener (MouseEvent.MOUSE_DOWN, onCardMouseDown);
            sensor.removeEventListener (MouseEvent.MOUSE_UP, onCardMouseUp);
            sensorStack.removeChild (sensor);
<<<<<<< HEAD
			
			var cardIndex:int = cardsStack.getChildIndex(actualCard);
			
			stopGlowCards ();
			
			cardsStack.removeChild (actualCard);
            actualCard.filters = null;

            dispatchEvent (new DeckEvent(DeckEvent.PLAYER_CARD_PLAY, {index: cardIndex}));
			
			
=======

            cardsStack.removeChild (actualCard);
            actualCard.filters = null;


            dispatchEvent (new DeckEvent(DeckEvent.PLAYER_CARD_PLAY, {'index':cardsStack.getChildIndex(actualCard)}));
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

        } else {

            skipPlaingCard ();
        }

    }
<<<<<<< HEAD
	
	public function getActualCard () :Card {
		return actualCard;
	}
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public function removePlayingCard () :void {
        dragMode = false;
        if (mirrorStack.contains(mirror)) {
            mirrorStack.removeChild (mirror);
        }
        sortCollodion ();
    }

    private function onCardMouseUp (event:MouseEvent) :void {
<<<<<<< HEAD
=======

        dragMode = false;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        mirror.stopDrag ();
        skipPlaingCard ();
    }

    private function skipPlaingCard () :void {
        if (mirrorStack.contains(mirror)) {
            mirrorStack.removeChild (mirror);
        }
        actualCard.visible = true;
<<<<<<< HEAD
		dragMode = false;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }

    public function setPlayDistance (value:int) :void {
        playDistance = value;
    }

}
}
