package com.la.mvc.controller.match.scenario.actions 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.model.CardData;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.deck.EnemyDeck;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.scene.IScene;
	import com.la.mvc.view.token.Token;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ReplaceCardAndToken extends Command 
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
			console.debug ('ReplaceCardAndToken::execute');
			var card:Card = event.data.targetCard;
			card.filters = []
			var token:Token = event.data.targetToken as Token;
			
			var cardPosition:Point = new Point (card.x, card.y);
			cardPosition = card.parent.localToGlobal (cardPosition);
			
			var tokenPosition:Point = new Point (token.x, token.y); 
			tokenPosition = token.parent.localToGlobal (tokenPosition);
			tokenPosition.x += ((token.width - card.width) / 2);
			if (!event.data.associate) {
				tokenPosition.y += (token.height - card.height);
			}
			
			var newCard:Card;
			
			
			if (event.data.associate) {
				newCard = playerDeck.changeCard (card, event.data.initiatorCardDara);
			} else {
				newCard = enemyDeck.changeCard (card, event.data.initiatorCardDara);	
			}
			var cardEndPosition:Point = new Point (newCard.x, newCard.y);
			var cardStartPosition:Point = newCard.parent.globalToLocal(tokenPosition);
			newCard.x = cardStartPosition.x;
			newCard.y = cardStartPosition.y;
			TweenLite.to (newCard, 0.5, { x:cardEndPosition.x, y:cardEndPosition.y, ease:Expo.easeOut } );
		
			
			scene.placeCard (card);
			card.x = cardPosition.x;
			card.y = cardPosition.y;
			
			TweenLite.to (card, 0.5, {x:tokenPosition.x, y:tokenPosition.y, ease:Expo.easeOut, onComplete:onTweenComplete})
			
		}	
		
		private function onTweenComplete () :void {
			var token:Token = event.data.targetToken as Token;
			var cardData:CardData = event.data.cardData;
			field.changeToken (token, cardData);
			scene.endPlaceCard();
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
	}

}