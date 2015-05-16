package com.la.mvc.controller.match.deck 
{
	import com.greensock.easing.Expo;
	import com.greensock.easing.ExpoInOut;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IToken;
	import com.la.mvc.view.scene.IScene;
	import com.la.mvc.view.token.Token;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ShuffleTokenIntoDeckCommand extends Command 
	{
		[Inject (name='field')]
		public var field:IField; 
		
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		private var animationCof:int;
		private var mirrors:Array 
				
		override public function execute():void 
		{
			animationCof = event.data.targets.length;
			mirrors = [];

			for (var i:int = 0; i < event.data.targets.length; i ++) {
				var data:Object = event.data.targets[i];
				var card:Card = new Card(data.card);
				var target:IToken = data.target as IToken;
				var tokenDO:DisplayObject = target as DisplayObject;
				var position:Point = new Point (tokenDO.x, tokenDO.y);
				position = tokenDO.parent.localToGlobal(position);
				card.getMirror().x = position.x;
				card.getMirror().x += (Token.WIDTH - card.getMirror().width) / 2; 
				card.getMirror().y = position.y;
				if (target.isEnemy) {
					card.getMirror().y += (Token.HEIGHT - card.getMirror().height); 
				}
				scene.placeCard(card.getMirror());
				mirrors.push(card.getMirror());
				card.getMirror().alpha = 0;
				field.remove(tokenDO);
				
				TweenLite.to (card.getMirror(), 1.0, { alpha:1, onComplete:onAlphaComplete});
			}
		}	
		
		private function onAlphaComplete() :void {
			animationCof --;
			if (!animationCof) {
				field.sortAndCenterize();
				tweenMirrors();
			}
		}
		
		private function tweenMirrors () :void {
			if (!mirrors.length) {
				scene.endPlaceCard();
				dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			} else {
				var mirror:DisplayObject = mirrors.shift();
				TweenLite.to (mirror, 1.0, { x:contextView.stage.stageWidth, onComplete:onTweenComplete, ease:Expo.easeInOut, onCompleteParams:[mirror]});
			}
		}
		
		private function onTweenComplete (mirror:DisplayObject) :void {
			if (mirror.parent) {
				mirror.parent.removeChild(mirror);
			}
			tweenMirrors();
		}
	}

}