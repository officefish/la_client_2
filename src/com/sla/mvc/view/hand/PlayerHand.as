package com.sla.mvc.view.hand 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.indico.fan.FanData;
	import com.sla.event.starling.StarlingHandEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.card.CardSensor;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PlayerHand extends Hand 
	{
		private var sensorStack:Sprite;
		private var mirrorStack:Sprite;
		private var newCard:Card;
		private var spellMixin:int = 0;
		
		override protected function init():void 
		{
			super.init();
			
			mirrorStack = new Sprite();
			addChild(mirrorStack);
			
			sensorStack = new Sprite();
			addChild(sensorStack);
		}
		
		public function addMirror (mirror:Sprite) :void {
			mirrorStack.addChild(mirror);
		}
		
		public function clearMirrorStack() :void {
			mirrorStack.removeChildren();
		}
		
		override public function initCard(cardData:CardData):Card 
		{
			var card:Card = new Card (cardData);
			card.setSpellMixin(spellMixin);
			sensorStack.addChild(card.sensor);
			return card;
		}
				
		override protected function sort(quick:Boolean):void 
		{
			PlayerFanSettings.apply(cardsStack.numChildren, fan);
			var data:Vector.<FanData> = fan.calculate(cardsStack.numChildren, true);
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
					card.x = card.sensor.x = card.position.x;
					card.y = card.sensor.y = card.position.y;
					card.rotation = card.sensor.rotation = card.endRotation = fanData.rotation;
				} else {
					card.sensor.x = card.position.x;
					card.sensor.y = card.position.y;
					card.sensor.rotation = fanData.rotation;
					card.endRotation = card.sensor.rotation;
					
					timeline.to (card, 0.5, {x:card.position.x, y:card.position.y, rotation:card.sensor.rotation, ease:Expo.easeInOut}, 'spin');
				}	
			}
			
			if (!quick) {
				timeline.play();
			}
			//MonsterDebugger.log(data);
		}
		
		override public function pickCard(cardData:CardData):Card 
		{
			newCard = initCard(cardData);
			newCard.showDescription();
			PlayerFanSettings.apply(cardsStack.numChildren + 1, fan);
			var data:Vector.<FanData> = fan.calculate(cardsStack.numChildren + 1, true);
			var fanData:FanData;
			var card:Card;
			var cardMirror:Sprite = newCard.getMirror();
			var timeline:TimelineMax = new TimelineMax({onComplete:onPickComplete});
			timeline.pause();
			timeline.add('spin');
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				card = cardsStack.getChildAt(i) as Card;
				fanData = data[i];
				card.position = fanData.position;
				card.longPosition = fanData.longPosition;
				card.sensor.x = card.position.x;
				card.sensor.y = card.position.y;
				card.sensor.rotation = fanData.rotation;
				newCard.rotation = fanData.rotation;
				timeline.to (card, 0.5, {delay:1.5, x:card.position.x, y:card.position.y, rotation:newCard.rotation, ease:Expo.easeIn}, 'spin');
			}
			
			fanData = data[data.length - 1];
			newCard.position = fanData.position;
			newCard.longPosition = fanData.longPosition;
			cardMirror.x = stage.stageWidth / 2 + 400;
			cardMirror.y = 0;
			
			var scaleX:Number = (Card.CARD_WIDTH / Card.MIRROR_WIDTH) - 0.08;
			var scaleY:Number = (Card.CARD_HEIGHT - 4) / (Card.MIRROR_HEIGHT - 4);
			newCard.x = newCard.sensor.x = newCard.position.x;
			newCard.y = newCard.sensor.y = newCard.position.y;
			newCard.rotation = newCard.sensor.rotation = fanData.rotation;
			newCard.visible = false;
			
			this.addChild(cardMirror);
			
			cardsStack.addChild(newCard);
			newCard.sensor.visible = false;
			sensorStack.addChild(newCard.sensor);
			timeline.to (cardMirror, 1.5, { x:stage.stageWidth / 2 - 300, y: -300, ease:Expo.easeInOut }, 'spin');
			timeline.to (cardMirror, 0.5, {delay:1.5, x:newCard.position.x - 5, y:newCard.position.y, rotation:newCard.rotation, scaleX:scaleX, scaleY:scaleY, ease:Expo.easeIn}, 'spin');
			
			
			timeline.play();
			return newCard;
			
		}
		
		private function onPickComplete () :void {
			newCard.visible = true;
			if (this.contains(newCard.getMirror())) {
				removeChild(newCard.getMirror());
				newCard.getMirror().rotation = 0;
				newCard.getMirror().scaleX = 1;
				newCard.getMirror().scaleY = 1;
				newCard.sensor.visible = true;
			}
			dispatchEvent(new StarlingHandEvent(StarlingHandEvent.PICK_COMPLETE))
		}
		
		private function degreesToRadians(degrees:Number):Number {
			return degrees * Math.PI / 180;
		}
		
		override public function removeCard(card:Card):void 
		{
			//MonsterDebugger.log('removeCard');
			cardsStack.removeChild(card);
			sensorStack.removeChild(card.sensor);
			//MonsterDebugger.log('numCHildren:' + cardsStack.numChildren);
			sort(false);
		}
		
		public function glowCards (mana:int, numMinions:int = 0) :void {
			var card:Card;
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				card = cardsStack.getChildAt(i) as Card;
				if (card.getPrice() <= mana) {
					if (card.getCardData().type == CardData.UNIT && numMinions >= 7) {
						card.stopGlow();
					} else {
						card.glow();
					}
				} else {
					card.stopGlow();
				}
				
			}
		}
		
		public function stopGlowCards () :void {
			var card:Card;
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				card = cardsStack.getChildAt(i) as Card;
				card.stopGlow();
			}
		}
		
		public function setSpellMixin(value:int) :void {
			spellMixin = value;
			for (var i:int = 0; i < cardsStack.numChildren; i ++) {
				var card:Card = cardsStack.getChildAt(i) as Card;
				card.setSpellMixin(spellMixin);
			}
		}
		
		override public function clear():void 
		{
			mirrorStack.removeChildren();
			cardsStack.removeChildren();
			sensorStack.removeChildren();
		}
		
		
		
	}

}