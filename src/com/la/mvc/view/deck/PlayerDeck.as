/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.deck {
import adobe.utils.ProductManager;
import com.greensock.TimelineLite;
import com.greensock.easing.Expo;
import com.greensock.TweenLite;
import com.hurlant.util.der.OID;
import com.la.event.ConsoleEvent;
import com.la.event.DeckEvent;
import com.la.event.ScenarioEvent;
import com.la.mvc.model.CardType;
import com.la.mvc.view.card.Card;
import com.la.mvc.view.card.CardSensor;
import com.la.mvc.model.CardData;
import flash.display.DisplayObject;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Point;
import com.demonsters.debugger.MonsterDebugger;


public class PlayerDeck extends Deck {

    private var mirrorStack:Sprite;
    private var sensorStack:Sprite;
    private var playDistance:int;
	private var spellMixin:int = 0;
	


    public function PlayerDeck() {
        super ();
        mirrorStack = new Sprite ();
        addChild (mirrorStack);

        sensorStack = new Sprite ();
        addChild (sensorStack);
    }
	
	override public function clear():void 
	{
		while (mirrorStack.numChildren) {
			mirrorStack.removeChildAt(0);
		}
		while (sensorStack.numChildren) {
			sensorStack.removeChildAt(0);
		}
		while (cardsStack.numChildren) {
			cardsStack.removeChildAt(0);
		}
	}
	
	public function allCardsVisible():void {
		for (var i:int = 0; i < cardsStack.numChildren; i ++) {
			var card:DisplayObject = cardsStack.getChildAt(i);
			card.visible = true;
		}
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
			card.setSpellMixin(spellMixin);

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
            return card;


        }
		
		public function newCard (cardData:CardData, animation:Boolean = true) :void {
			var card:Card = new Card (cardData);
			card.setSpellMixin(spellMixin);
            cardsStack.addChildAt (card, cardsStack.numChildren);
            var sensor:CardSensor = card.getSensor();
            sensorStack.addChild (sensor);
            sortCollodion ();
			
			if (animation) {
				var yCof:int = card.y;
				card.y -= 100;
				TweenLite.to (card, 0.5, { y:yCof, ease:Expo.easeOut, onComplete:onNewCardComplete});
			} else {
				dispatchEvent(new ScenarioEvent(ScenarioEvent.ACTION));
			}
			
		}
		
		private function onNewCardComplete () :void {
			dispatchEvent(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
		public function addMirror (mirror:Sprite) :void {
			mirrorStack.addChild(mirror);
		}
		
		public function clearMirrorStack () :void {
			while (mirrorStack.numChildren) mirrorStack.removeChildAt(0);
		}
		
		private function onAddCardComplete (card:Card) :void {
            scene.endPlaceCard();
            card.visible = true;
			dispatchEvent(new ScenarioEvent(ScenarioEvent.ACTION));
        }
		
		public function changeCard (card:Card, cardData:CardData) :Card {
						
			var newCard:Card = new Card (cardData);
			card.setSpellMixin(spellMixin);
			var position:Point = new Point (card.x, card.y);
			
			var index:int = cardsStack.getChildIndex (card);
			var sensor:CardSensor = card.getSensor();
            sensorStack.removeChild (sensor);
			cardsStack.removeChildAt (index);
			
            cardsStack.addChildAt (newCard, index);
			sensor = newCard.getSensor();
            sensorStack.addChildAt (sensor, index);
			
			newCard.x = sensor.x = position.x;
			newCard.y = sensor.y = position.y;
			
			return newCard;
			
			
		

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
		
		public function getCards () :Array {
			var arr:Array = []
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				arr.push (cardsStack.getChildAt(i));
			}
			return arr;
		}

       // override public function block () :void {
     //      blockFlag = true;
     //   }

     /*  
	 override public function unblock(endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void {
            blockFlag = false;
			_dragMode = false;
			if (sygnalFlag) {
				dispatchEvent (new ScenarioEvent (ScenarioEvent.ACTION));		
			}
        }
	*/
		
	override public function sort(endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false):void 
	{
		sortCollodion();
		
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


	public function getPlayDistance() :int {
		return playDistance;
	}
	
	
    public function destroyCard (card:Card) :void {
		var sensor:CardSensor = card.getSensor();
        if (sensorStack.contains(sensor)) {
			sensorStack.removeChild (sensor);
		}
		var mirror:Sprite = card.getMirror();
		if (mirror.parent) {
			mirror.parent.removeChild(mirror);
		}
		if (cardsStack.contains(card)) {
			cardsStack.removeChild (card);
		}
		mirror.visible = true;
	    card.filters = null;
		stopGlowCards ();
		
		sortCollodion ();
	}
	
	public function getCardIndex (card:Card) :int {
		var cardIndex:int = cardsStack.getChildIndex(card);
		return cardIndex;
	}
	
	
    public function setPlayDistance (value:int) :void {
        playDistance = value;
    }
	
	public function getLastCard () :Card {
		return cardsStack.getChildAt (cardsStack.numChildren - 1) as Card;
	}
	
	public function getCardByIndex (index:int) :Card {
		return cardsStack.getChildAt (index) as Card;
	}
		
	public function glowCard (card:Card) :void {
		 card.filters = [new GlowFilter(0x00FFFF)]
	}
	
	public function setSpellMixin (value:int) :void {
		spellMixin = value;
		for (var i:int = 0; i < cardsStack.numChildren; i ++) {
			var card:Card = cardsStack.getChildAt(i) as Card;
			card.setSpellMixin(spellMixin);
		}
	}
	
	

}
}
