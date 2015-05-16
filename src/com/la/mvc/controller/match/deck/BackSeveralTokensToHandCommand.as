package com.la.mvc.controller.match.deck 
{
	import com.greensock.easing.Expo;
	import com.greensock.TimelineLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.deck.EnemyDeck;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.scene.IScene;
	import com.la.mvc.view.token.Token;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BackSeveralTokensToHandCommand extends Command 
	{
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck;
		
		[Inject (name='field')]
		public var field:IField;
		
		[Inject (name='enemyDeck')]
		public var enemyDeck:EnemyDeck; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject]
		public var event:SceneEvent;
		
		
		[Inject (name='appConsole')]
		public var console:Console;
		
		private var animationCof:int;
		
		
		
		override public function execute():void 
		{
			var assotiateTargets:Array;
			var opponentTargets:Array;
			var targetData:Object;
			var card:Card;
			var endPosition:Point;
			var startPosition:Point;
			var target:DisplayObject;
			var mirror:DisplayObject;
			var middlePosition:Point;
			var timeline:TimelineLite;
			animationCof = 0;
			
			if (event.data.client) {
				assotiateTargets = event.data.associateTargets;
				opponentTargets = event.data.opponentTargets;
			} else {
				assotiateTargets = event.data.opponentTargets;
				opponentTargets = event.data.associateTargets;
			}
			
			
			var cards:Array = [];
			for (var i:int = 0; i < assotiateTargets.length; i ++) {
				targetData = assotiateTargets[i];
				card = playerDeck.addCard(targetData.card);
				cards.push({'card':card,'target':targetData.target})
			}
			
			var opponentCards:Array = [];
			for (i = 0; i < opponentTargets.length; i ++) {
				targetData = opponentTargets[i];
				card = enemyDeck.addCard(targetData.card, false);
				opponentCards.push({'card':card,'target':targetData.target})
			}
			enemyDeck.sort();
			
			for (i = 0; i < cards.length; i ++) {
				card = cards[i].card;
				
				endPosition = new Point(card.x, card.y);
				endPosition = card.parent.localToGlobal(endPosition);
				card.visible = false;
				
				target = cards[i].target as DisplayObject;
				
				startPosition = new Point(target.x, target.y);
				startPosition = target.parent.localToGlobal(startPosition);
				field.remove(target);

											
				mirror = card.getMirrorBitmap();
				startPosition.x += (Token.WIDTH - mirror.width) / 2;
				
				mirror.x = startPosition.x;
				mirror.y = startPosition.y;
				mirror.scaleX = 1;
				mirror.scaleY = 1;
				mirror.alpha = 0;
				
				scene.placeCard(mirror);
				animationCof ++;
								
				middlePosition = new Point(startPosition.x, contextView.stage.stageHeight / 2);
				timeline = new TimelineLite ({delay:0.1, onComplete:onPlaceComplete});
				timeline.to (mirror, 0.5, { y:middlePosition.y, alpha:1, ease:Expo.easeOut} );
				timeline.to (mirror, 0.5, { x:endPosition.x, y:endPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeIn}); 
			}
			
			for (i = 0; i < opponentCards.length; i ++) {
				card = opponentCards[i].card;
				
				endPosition = new Point(card.x, card.y);
				endPosition = card.parent.localToGlobal(endPosition);
				card.visible = false;
				
				target = opponentCards[i].target as DisplayObject;
				startPosition = new Point(target.x, target.y);
				startPosition = target.parent.localToGlobal(startPosition);
				field.remove(target);
											
				mirror = card.getShirt();
				startPosition.x += (Token.WIDTH - mirror.width) / 2;
				startPosition.y += (Token.HEIGHT - mirror.height);
				
				mirror.x = startPosition.x;
				mirror.y = startPosition.y;
				mirror.scaleX = 1;
				mirror.scaleY = 1;
				mirror.alpha = 0;
				
				scene.placeCard(mirror);
				
				animationCof ++;
								
				middlePosition = new Point(startPosition.x, (contextView.stage.stageHeight / 2) - mirror.height);
				timeline = new TimelineLite ({delay:0.1, onComplete:onPlaceComplete});
				timeline.to (mirror, 0.5, { y:middlePosition.y, alpha:1, ease:Expo.easeOut} );
				timeline.to (mirror, 0.5, { x:endPosition.x, y:endPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeIn}); 
			}
						
			field.removeAllTokens();
			
		}	
		
		
		private function onPlaceComplete () :void {
			animationCof --;
			if (!animationCof) {
				scene.endPlaceCard();
				playerDeck.allCardsVisible();
				enemyDeck.allCardsVisible();
				enemyDeck.sort();
				dispatch(new ScenarioEvent(ScenarioEvent.ACTION))
			}
		
		}
	}

}