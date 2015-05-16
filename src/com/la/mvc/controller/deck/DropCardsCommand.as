package com.la.mvc.controller.deck 
{
	import com.greensock.easing.Expo;
	import com.greensock.easing.Power0;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.deck.EnemyDeck;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.scene.IScene;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DropCardsCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
				
		[Inject (name='enemyDeck')]
		public var enemyDeck:EnemyDeck; 
		
		private var animationCof:int = 0;
		
		override public function execute():void 
		{
			var cards:Array = event.data.cards;
						
			for (var i:int = 0; i < cards.length; i ++) {
				var cardData:Object = cards[i];
				var card:Card = cardData.card;
				var position:Point = new Point (card.x, card.y);
				position = card.parent.localToGlobal (position);
				var preview:Sprite = card.getMirror();
				position.x += (card.width - preview.width) / 2;
				
				var endPosition:Point = new Point();
				var distance:int = (position.x - (contextView.stage.stageWidth / 2)) * 0.3; 
				endPosition.x = position.x + distance;
				endPosition.y = position.y;
				
				if (event.data.attachment == 1) {
					if (event.data.clientFlag) {
						playerDeck.destroyCard(card);
						endPosition.y -= 230;
						
					} else {
						card = new Card(cardData.model);
						preview = card.getMirror();
						enemyDeck.removeCardAt (cardData.index);
						position.y += (card.height - preview.height);
						endPosition.y += 230;
					}
				} else {
					if (event.data.clientFlag) {
						card = new Card(cardData.model);
						preview = card.getMirror();
						enemyDeck.removeCardAt (cardData.index);
						position.y += (card.height - preview.height);
						endPosition.y += 230;
					} else {
						playerDeck.destroyCard(card)
						endPosition.y -= 230;
					}	
				}
				
				preview.x = position.x;
				preview.y = position.y;
				scene.placeCard(preview);
				
				animationCof ++;
				
				TweenLite.to (preview, 0.8, {x:endPosition.x, y:endPosition.y, ease:Expo.easeOut, onComplete:onTweenComplete});
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}	
		
		private function onTweenComplete () :void {
			animationCof --;
			if (!animationCof) {
				scene.endPlaceCard();
			}
		}
	}

}