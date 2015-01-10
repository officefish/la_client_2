package com.la.mvc.controller.match.deck 
{
	import com.greensock.easing.Expo;
	import com.greensock.TimelineLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.debug.Console;
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

		
		override public function execute():void 
		{
			console.debug ('BackTokenToHandCommand::execute');
			//console.debug (event.data.cardData);
			var token:DisplayObject = event.data.token;
			
			card = playerDeck.addCard(event.data.cardData);
			card.visible = false;
			
			mirror = card.getMirrorBitmap ();
			
			var startPosition:Point = new Point (token.x, token.y);
			startPosition = token.parent.localToGlobal (startPosition);
			startPosition.x -= ((mirror.width - token.width) / 2);
			
			mirror.x = startPosition.x;
			mirror.y = startPosition.y;
			mirror.alpha = 0;
			mirror.scaleX = 1;
			mirror.scaleY = 1;
			
			var middlePosition:Point = new Point(startPosition.x, contextView.stage.stageHeight / 2);
			
			var endPosition:Point = new Point (card.x, card.y);
			endPosition = card.parent.localToGlobal (endPosition);
			
			scene.placeCard(mirror); 
			
			var timeline:TimelineLite = new TimelineLite ({onComplete:onPlaceComplete});
			timeline.to (mirror, 0.5, { y:middlePosition.y, alpha:1, ease:Expo.easeOut, onComplete:onPlaceContinue } );
			timeline.to (mirror, 0.5, { x:endPosition.x, y:endPosition.y, scaleX:0.72, scaleY:0.72, ease:Expo.easeIn}); 
		}
		
		private function onPlaceContinue () :void {
			var targetIndex:int = event.data.targetIndex;
			var targetAttachment:Boolean = event.data.targetAttachment;
			if (event.data.clientFlag) {
				if (targetAttachment) {
					field.removeToken (targetIndex, true);
				} else {
					field.removeToken (targetIndex, false);
				}
			} else {
				if (targetAttachment) {
					field.removeToken (targetIndex, false);
				} else {
					field.removeToken (targetIndex, true);
				}
			}
		}
			//var index:int = field.getTokenIndex(event.data.token);
		
		
		private function onPlaceComplete () :void {
			scene.endPlaceCard ();
			mirror.scaleX = 1;
			mirror.scaleY = 1;
			card.visible = true;
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
	}

}