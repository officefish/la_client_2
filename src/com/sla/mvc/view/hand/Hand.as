package com.sla.mvc.view.hand 
{
	import com.indico.fan.Fan;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.card.Card;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Hand extends Sprite 
	{
		
		protected var cardsStack:Sprite;
		private var initFlag:Boolean = false;
		private var stageWidth:int;
		private var stageHeight:int;
		protected var fan:Fan;
		
		public function Hand() 
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
		}
		
		private function onAddedToStage (event:Event) :void {
			if (initFlag) return;
			init();
			initFlag = true;
		}
		
		protected function init () :void {
			cardsStack = new Sprite();
			addChild(cardsStack);
		}
				
		public function addCards (cards:Vector.<CardData>, quick:Boolean = false) :Vector.<Card> {
			var card:Card;
			var vector:Vector.<Card> = new Vector.<Card>();
			var length:int = cards.length;
			for (var i:int = 0; i < length; i++) {
				card = addCard(cards[i], quick);
				vector.push(card);
			}

			return vector;
		}
		
		public function addCard (cardData:CardData, quick:Boolean = false) :Card {
			var card:Card = initCard(cardData);
			cardsStack.addChildAt (card, cardsStack.numChildren);
			sort(quick);
			return card;
		}
		
		public function pickCard (cardData:CardData) :Card {
			return null;
		}
		
		public function initCard (cardData:CardData) :Card {
			var card:Card = new Card (cardData);
			return card;
		}
		
		public function initFan () :void {
			this.fan = new Fan();
			fan.long = 25;
		}
		
		protected function sort(quick:Boolean) :void {
            						
        }
		
		
		public function getCards () :Vector.<Card> {
			var vector:Vector.<Card> = new Vector.<Card>();
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				vector.push(cardsStack.getChildAt(i) as Card)
			}
			return vector;
		}
		
		public function getCardIndex(card:Card) :int {
			return cardsStack.getChildIndex(card);
		}
		
		public function getCard (index:int) :Card {
			return cardsStack.getChildAt(index) as Card;
		}
		
		public function removeCard (card:Card) :void {
			
		}

	}

}