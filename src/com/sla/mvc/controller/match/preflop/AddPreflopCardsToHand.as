package com.sla.mvc.controller.match.preflop 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.easing.ExpoInOut;
	import com.greensock.easing.Power0;
	import com.greensock.TimelineMax;
	import com.indico.fan.Fan;
	import com.sla.event.MatchEvent;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.card.PreflopCard;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.PreflopPopup;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AddPreflopCardsToHand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var hand:PlayerHand;
		
		[Inject]
		public var preflop:PreflopPopup;
		
		[Inject]
		public var scene:Scene; 
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero; 

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('AddPreflopCardsToHand::execute()');
			
			hand.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			hand.initFan();
			hand.y = contextView.stage.stageHeight + 7;
			hand.x = contextView.stage.stageWidth / 2;
			contextView.addChild(hand);
			
			hand.visible = false;
			hand.addCards(event.data.cards, true);
			
			var darkenSprite:Sprite = scene.getDarkenSprite();
						
			var timeline:TimelineMax = new TimelineMax({ onComplete:onTimelineComplete });
			timeline.pause();
			timeline.add('spin');
			
			
			var preflopCards:Vector.<PreflopCard> = preflop.getPreflopCards();
			var cards:Vector.<Card> = hand.getCards();
			var preflopCard:PreflopCard;
			var card:Card;
			var cardPosition:Point;
			var scaleX:Number = (Card.CARD_WIDTH / Card.MIRROR_WIDTH) - 0.08;
			var scaleY:Number = (Card.CARD_HEIGHT - 4) / (Card.MIRROR_HEIGHT - 4);
			var length:uint = cards.length;
			var speed:Number = 0.8;
			var ease:* = Expo.easeIn; // Power0.easeNone
			
			timeline.to (darkenSprite, speed, { alpha:0, ease:ease }, 'spin');
			
			for (var i:int = 0; i < length; i ++) {
				card = cards[i];
				preflopCard = preflopCards[i];
				cardPosition = new Point(card.x, card.y);
				cardPosition = card.parent.localToGlobal(cardPosition);
				timeline.to(preflopCard, speed, { x:cardPosition.x - 5, alpha:0.8, y:cardPosition.y, scaleX:scaleX, scaleY:scaleY, rotation:card.rotation, ease:ease }, 'spin');
			}
			
			timeline.play();
		}
		
		private function onTimelineComplete () :void {
			hand.visible = true;
			preflop.clear();
			
			scene.removeDarken();
			scene.getDarkenSprite().alpha = 1;
			scene.stopDarkenHeroes();
			
			playerHero.showHealth();
			opponentHero.showHealth();
			
			dispatch(new MatchEvent(MatchEvent.READY));
		}
	}

}