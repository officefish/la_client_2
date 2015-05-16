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
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BackTokenToHandCommand extends Command 
	{
		
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck;
		
		private var card:Card;
		private var mirror:DisplayObject;
		
		[Inject (name='scene')]
		public var scene:IScene;
		
		[Inject (name='field')]
		public var field:IField; 
		
		private var playerFlag:Boolean = true;
		
		[Inject (name='enemyDeck')]
		public var enemyDeck:EnemyDeck; 
		
		
		override public function execute():void 
		{
			var token:DisplayObject = event.data.token;
			
			var targetIndex:int = event.data.targetIndex;
			var targetAttachment:Boolean = event.data.targetAttachment;
			if (event.data.clientFlag) {
				if (targetAttachment) {
					playerFlag = true;
				} else {
					playerFlag = false;
				}
			} else {
				if (targetAttachment) {
					playerFlag = false;
				} else {
					playerFlag = true;
				}
			}
			
			if (playerFlag) {
				card = playerDeck.addCard(event.data.cardData); 
			} else {
				card = enemyDeck.addCard(event.data.cardData, false);
			}
			
			card.visible = false;
			
			if (playerFlag) {
				mirror = card.getMirrorBitmap ();
			} else {
				mirror = card.getShirt();
			}
			
			var startPosition:Point = new Point (token.x, token.y);
			startPosition = token.parent.localToGlobal (startPosition);
			startPosition.x -= ((mirror.width - token.width) / 2);
			
			if (!playerFlag) {
				startPosition.y -= (mirror.height - token.height);
			}
			
			mirror.x = startPosition.x;
			mirror.y = startPosition.y;
			mirror.alpha = 0;
			mirror.scaleX = 1;
			mirror.scaleY = 1;
			
			var middlePosition:Point = new Point(startPosition.x, contextView.stage.stageHeight / 2);
			
			if (!playerFlag) {
				middlePosition.y -= mirror.height;
			}
			
			var endPosition:Point = new Point (card.x, card.y);
			endPosition = card.parent.localToGlobal (endPosition);
			
			scene.placeCard(mirror); 
			
			var timeline:TimelineLite = new TimelineLite ({onComplete:onPlaceComplete});
			timeline.to (mirror, 0.5, { y:middlePosition.y, alpha:1, ease:Expo.easeOut, onComplete:onPlaceContinue } );
			timeline.to (mirror, 0.5, { x:endPosition.x, y:endPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeIn}); 
		}
		
		private function onPlaceContinue () :void {
			var targetIndex:int = event.data.targetIndex;
			field.removeToken (targetIndex, playerFlag);
		}
		
		
		private function onPlaceComplete () :void {
			scene.endPlaceCard ();
			mirror.scaleX = 1;
			mirror.scaleY = 1;
						
			card.visible = true;
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
	}

}