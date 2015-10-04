package com.sla.mvc.view.hand 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.data.TweenLiteVars;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.indico.fan.FanData;
	import com.sla.event.starling.StarlingHandEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.card.Card;
	import flash.geom.Point;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class OpponentHand extends Hand 
	{
		private var newCard:Card;
		
		public function OpponentHand() 
		{
			super();
		}
		
		public function preflopCards (cards:Vector.<CardData>) :void {
			cardsStack.visible = false;
			addCards(cards, true);
			var timeline:TimelineMax = new TimelineMax();
			timeline.pause();
			timeline.add('spin')
			var card:Card;
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				card = cardsStack.getChildAt(i) as Card;
				card.x = this.stage.stageWidth/2 + 100;
				card.y = 100;
				timeline.to (card, 1.5, {x:card.position.x, y:card.position.y, ease:Expo.easeInOut, delay:0.1*i}, 'spin');
			}
			cardsStack.visible = true;
			timeline.play();
		}
		
		override public function initCard(cardData:CardData):Card
		{
			var card:Card = new Card (cardData);
			card.shirtMode = true;
			return card;
		}
		
		override protected function sort(quick:Boolean):void 
		{
			PlayerFanSettings.apply(cardsStack.numChildren, fan);
			var data:Vector.<FanData> = fan.calculate(cardsStack.numChildren, false);
			var fanData:FanData; 
			var card:Card;
			if (!quick) {
				var timeline:TimelineMax = new TimelineMax();
				timeline.add('spin');
				timeline.pause();
			}
			
			for (var i:int = 0; i < data.length; i ++) {
				card = cardsStack.getChildAt(i) as Card;
				fanData = data[i];
				card.position = fanData.position;
				card.longPosition = fanData.longPosition;
				if (quick) {
					card.x = card.position.x;
					card.y = card.position.y;
					card.rotation = fanData.rotation;
				} else {
					card.sensor.rotation = fanData.rotation;
					// грубый фикс лучше поправить в классе fan но я не знаю как
					if (Math.abs(card.sensor.rotation - card.rotation) > 5) {
						card.rotation = card.sensor.rotation;
					}
					//
					timeline.to (card, 0.5, {x:card.position.x, y:card.position.y, rotation:card.sensor.rotation, ease:Expo.easeInOut}, 'spin');

				}
			}
			
			if (!quick) {
				timeline.play();
			}
		}
		
		public function changeCards (data:Array) :void {
			var timeline:TimelineMax = new TimelineMax();
			timeline.pause();
			timeline.add('spin');
			var index:int;
			var card:Card;
			for (var i:int = 0; i < data.length; i ++) {
				index = data[i].index;
				card = cardsStack.getChildAt(index) as Card;
				timeline.to(card, 0.8, {x:stage.stageWidth / 2 + 40, y:100, ease:Expo.easeIn, delay:0.1*i}, 'spin');
				timeline.to(card, 0.8, {x:card.position.x, y:card.position.y, ease:Expo.easeIn, delay:1.0 + 0.1*i}, 'spin');
			}
			timeline.play();
		}
		
		public function click (index:uint, select:Boolean) :void {
			var card:Card = cardsStack.getChildAt(index) as Card;
			var position:Point;
			if (select) {
				position = card.position;
			} else {
				position = card.longPosition;
			}
			TweenLite.to (card, 0.8, {x:position.x, y:position.y, ease:Expo.easeInOut});
		}
		
		override public function pickCard(cardData:CardData):Card 
		{
			newCard = initCard(cardData);
			PlayerFanSettings.apply(cardsStack.numChildren + 1, fan);
			var data:Vector.<FanData> = fan.calculate(cardsStack.numChildren + 1, false);
			var fanData:FanData;
			var card:Card;
			var shirt:Sprite = newCard.getShirt();
			var timeline:TimelineMax = new TimelineMax({onComplete:onPickComplete});
			timeline.pause();
			timeline.add('spin');
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				card = cardsStack.getChildAt(i) as Card;
				fanData = data[i];
				card.position = fanData.position;
				card.longPosition = fanData.longPosition;
				card.rotation = fanData.rotation;
				timeline.to (card, 0.8, {x:card.position.x, y:card.position.y, ease:Expo.easeOut}, 'spin');
			}
			fanData = data[data.length - 1];
			newCard.position = fanData.position;
			newCard.longPosition = fanData.longPosition;
			
			var scaleX:Number = (Card.CARD_WIDTH / Card.MIRROR_WIDTH) - 0.08;
			var scaleY:Number = (Card.CARD_HEIGHT - 4) / (Card.MIRROR_HEIGHT - 4);
			newCard.x = newCard.position.x;
			newCard.y = newCard.position.y;
			newCard.rotation = fanData.rotation;
			newCard.visible = false;
			
			shirt.rotation = degreesToRadians(180);
			
			this.addChild(shirt);
			
			shirt.x = stage.stageWidth/2 + 200;
			shirt.y = 200;
			
			cardsStack.addChild(newCard);
			timeline.to (shirt, 0.8, { x:newCard.position.x + 5, y:newCard.position.y, scaleX:scaleX, scaleY:scaleY, rotation:newCard.rotation, ease:Expo.easeOut }, 'spin');
						
			timeline.play();
			return newCard;
			
			//dispatchEvent(new StarlingHandEvent(StarlingHandEvent.PICK_COMPLETE));
			//return addCard(cardData, true);
		}
		
		private function degreesToRadians(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		private function onPickComplete () :void {
			newCard.visible = true;
			if (this.contains(newCard.getShirt())) {
				removeChild(newCard.getShirt());
				newCard.getShirt().rotation = 0;
				newCard.getShirt().scaleX = 1;
				newCard.getShirt().scaleY = 1;
			}
			dispatchEvent(new StarlingHandEvent(StarlingHandEvent.PICK_COMPLETE))
		}
		
		override public function removeCard(card:Card):void 
		{
			cardsStack.removeChild(card);
			sort(false);
		}
		
	}

}