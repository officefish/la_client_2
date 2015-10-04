package com.sla.mvc.view.scene 
{
	import com.greensock.easing.Expo;
	import com.greensock.easing.ExpoOut;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.sla.event.starling.StarlingSceneEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.card.PreflopCard;
	import feathers.controls.Button;
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreflopPopup extends Sprite 
	{
		
		private var stageWidth:int;
		private var stageHeight:int;
		private var _animationCof:int;
		private var selectButton:Button;
		
		private var container:Sprite;
		
		private var _newPreflopPositions:Vector.<Point>;
		private var backToDeckCards:Array;
		private var _preflopCards:Vector.<PreflopCard>;
		
		public function PreflopPopup() 
		{
			super();
			selectButton = new Button();
			selectButton.styleNameList.add("mainButton");
			selectButton.label = 'Select';
			selectButton.addEventListener ( Event.TRIGGERED, onSelect);
			
			container = new Sprite();
			addChild(container);
		} 
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			selectButton.validate();
			selectButton.x = (stageWidth - selectButton.width) / 2;
            selectButton.y = stageHeight / 2 + 100;
			selectButton.useHandCursor = true;
		}
		
		public function previewCards (cards:Vector.<CardData>) :void {

			if (contains(selectButton)) {
				removeChild(selectButton);
			}
			
			var card:Card;
			var shift:int = 20; 
			_animationCof = 0;

			var startX:int = stageWidth / 2;
			var endX:int;
			var cardsWidth:int = cards.length * Card.MIRROR_WIDTH;
			cardsWidth += (cards.length - 1) * 20;
			var endX_Base:int = (stageWidth - cardsWidth) / 2; 
			
			var timeline:TimelineMax = new TimelineMax({onComplete:onPreviewComplete});
			timeline.pause();
			
			timeline.add('spin');

			for (var i:int = 0; i < cards.length; i ++) {
				card = new PreflopCard(cards[i], i); 
				//card.setSpellMixin(0)
				container.addChild(card);
				card.x = startX;
				card.y = this.stageHeight / 2 - 60;
				endX = endX_Base;
				endX += (Card.MIRROR_WIDTH + 20) * i + Card.MIRROR_WIDTH / 2;
				//card.buttonMode = true;
				timeline.to (card, 1.2, {x:endX, ease:Expo.easeInOut}, 'spin');
			}
			
			timeline.play();
		}
		
		public function onPreviewComplete () :void {
			for (var i:int = 0; i < container.numChildren; i ++) {
				var card:PreflopCard = container.getChildAt(i) as PreflopCard;
				if (card) card.glow();
			}
			addChild(selectButton);
			
		}
		
		public function onSelect (event:Event) :void {
			changePreflopCards()
		}
		
		public function changePreflopCards () :void {
			if (contains(selectButton)) {
				removeChild(selectButton);
			}
						
			var cards:Vector.<PreflopCard> = getClassInstances(container, PreflopCard);
			
			
			backToDeckCards = [];
			var delay:Number = 0;
			_newPreflopPositions = new Vector.<Point>();
			
			var timeline:TimelineMax = new TimelineMax({onComplete:onReplaceComplete});
			timeline.pause();
			timeline.add('spin');
			var counter:uint = 0;
			
			for (var i:int = 0; i < cards.length; i ++) {
				var preflopCard:PreflopCard  = cards[i] as PreflopCard;
				preflopCard.block = true;
				if (!preflopCard.select) {
					counter ++;
					_newPreflopPositions.push(new Point (preflopCard.x, preflopCard.y)); 
					var data:Object = {'index':preflopCard.index, 'id':preflopCard.getCardData().id}
					backToDeckCards.push(data);
					container.addChild(preflopCard);
					timeline.to (preflopCard, 1.0, {
						x:stageWidth + 200,
						y:preflopCard.y,
						ease:Expo.easeIn,
						onComplete:onReplaceComponentComplete,
						onCompleteParams: [preflopCard],
						delay:delay
					}, 'spin');
					delay += 0.2;
				}
			}
			if (counter) {
				timeline.play();
				return;
			} else {
				dispatchEvent(new StarlingSceneEvent (StarlingSceneEvent.CHANGE_PREFLOP, false, {'replacement':[]}))
			}
			
			
		}
		
		private function getClassInstances (container:Sprite, cl:Class) :Vector.<PreflopCard> {
			var vector:Vector.<PreflopCard> = new Vector.<PreflopCard>();
			for (var i:int = container.numChildren - 1; i > -1; i --) {
				var child:PreflopCard = container.getChildAt(i) as PreflopCard;
				if (child is cl) {
					vector.push(child)
				}
			}
			return vector;
		}
		
		private function onReplaceComponentComplete (target:Sprite) :void {
			container.removeChild(target);
        }
		
		private function onReplaceComplete () :void {
			dispatchEvent(new StarlingSceneEvent (StarlingSceneEvent.CHANGE_PREFLOP, false, {'replacement':backToDeckCards}));
        }
		
		public function replaceCards (replacement:Vector.<CardData>) :void {
			if (!replacement.length) {
				preflopInit();
				return;
			}
			var timeline:TimelineMax = new TimelineMax({onComplete:onPreflopComplete});
			timeline.pause();
			timeline.add('spin');
			
			var delay:Number = 0;
			var position:Point;
			for (var i:int = 0; i < replacement.length; i ++) {
				var card:PreflopCard = new PreflopCard(replacement[i], i);
				card.block = true;
				//card.setSpellMixin(0);
				container.addChild(card);
				card.x = stageWidth + 100;
				card.y = this.stageHeight / 2 - 60;
				position = _newPreflopPositions.shift();
				timeline.to (card, 1.0, {delay:delay, x:position.x, ease:Expo.easeOut}, 'spin');
				delay += 0.2;
			}
			timeline.play();
		}

		private function onPreflopComplete () :void {
			preflopInit();
		}
		
		private function preflopInit () :void {
			var markToRemove:Vector.<Card> = new Vector.<Card>();
			initPreflopCards();
			for (var i:int = 0; i < _preflopCards.length; i ++) {
				container.addChild(_preflopCards[i]);
				_preflopCards[i].stopGlow();
			}
			dispatchEvent(new StarlingSceneEvent(StarlingSceneEvent.PREFLOP_INIT));
		}
		
		private function initPreflopCards () :void {
			_preflopCards = new Vector.<PreflopCard>();
			var item:PreflopCard;
			for (var i:int = 0; i < container.numChildren; i ++) {
				item = container.getChildAt(i) as PreflopCard;
				if (item) {
					_preflopCards.push(item);
				}
			}
			_preflopCards.sort(sortByXPosition);
			for (i = 0; i < _preflopCards.length; i ++) {
				container.addChild(_preflopCards[i]);
			}
		}

		private function sortByXPosition (a:PreflopCard, b:PreflopCard) :int {
		   var x1:int = a.x;
		   var x2:int = b.x;
		   if (x1 < x2)
		   {
				return -1;
		   }
		   else if (x1 > x2)
		   {
				return 1;
		   }
		   else
		   {
				return 0;
		   }
		}
		
		public function getPreflopCards () :Vector.<PreflopCard> {
			if (!_preflopCards) initPreflopCards();
			return _preflopCards; 
		}
		
		public function clear () :void {
			container.removeChildren();
		}
		
	}

}