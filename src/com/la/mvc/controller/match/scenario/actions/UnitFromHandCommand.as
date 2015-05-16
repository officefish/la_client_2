package com.la.mvc.controller.match.scenario.actions 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.deck.EnemyDeck;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IToken;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.model.CardData;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class UnitFromHandCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='field')]
		public var field:IField; 
		
		[Inject (name='enemyDeck')]
		public var enemyDeck:EnemyDeck; 
				
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		override public function execute():void 
		{
			var card:Card = event.data.targetCard;
			card.filters = [] 
			
			var cardPosition:Point = new Point (card.x, card.y);
			cardPosition = card.parent.localToGlobal (cardPosition); 
			
			scene.placeCard (card);
			card.x = cardPosition.x;
			card.y = cardPosition.y;
			
			var cardData:CardData = event.data.cardData; 
			field.addToken (event.data.associate, cardData, event.data.index, false, false);
			var token:DisplayObject = field.getToken(event.data.associate, event.data.index) as DisplayObject;
			var tokenPosition:Point = new Point(token.x, token.y);
			tokenPosition = token.parent.localToGlobal(tokenPosition);
			token.visible = false;
			tokenPosition.x = field.calculateX(event.data.associate, event.data.index);
			tokenPosition.x += (token.width - card.width) / 2;
			if (!event.data.associate) {
				tokenPosition.y += token.height - card.height; 
			}
			
			TweenLite.to (card, 0.5, { x:tokenPosition.x, y:tokenPosition.y, ease:Expo.easeOut, onComplete:onTweenComplete, onCompleteParams:[token, card] } );
		}
		
		private function onTweenComplete(token:DisplayObject, card:Card) :void {
			token.visible = true;
			scene.endPlaceCard();
			if (event.data.associate) {
				playerDeck.destroyCard(card)
			} else {
				enemyDeck.destroyCard(card);
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));  
			
		}
	}

}