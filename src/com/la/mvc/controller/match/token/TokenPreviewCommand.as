package com.la.mvc.controller.match.token 
{
	import com.greensock.TweenLite;
	import com.la.event.TokenEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.view.field.IToken;
	import com.la.mvc.view.scene.IScene;
	import com.la.mvc.view.token.Token;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class TokenPreviewCommand extends Command 
	{
		[Inject]
		public var event:TokenEvent;
		
     	[Inject (name='scene')]
		public var scene:IScene;
		
		[Inject (names = 'matchModel')]
		public var model:MatchModel;
		
		public var mirror:Sprite;

		override public function execute():void 
		{
			scene.endPreview();
			
			var token:IToken = event.getToken();
			var tokenDO:DisplayObject = token as DisplayObject;
			mirror = token.getMirror();
			mirror.alpha = 0;
			
			var position:Point = new Point (tokenDO.x, tokenDO.y);
			position = tokenDO.parent.localToGlobal (position);
			
			var centerX:int = contextView.stage.stageWidth / 2;
			if (position.x > centerX) {
				position.x -= (mirror.width + 10);
			} else {
				position.x += Token.WIDTH + 10;
			}
			position.y -= (mirror.height - Token.HEIGHT) / 2;
			
			mirror.x = position.x;
			mirror.y = position.y;
			
			scene.placePreview (mirror);
			
			if (model.previewTimer) {
				model.previewTimer.removeEventListener (TimerEvent.TIMER_COMPLETE, onTimerComplete);
				model.previewTimer.stop();
			}
			
			model.previewTimer = new Timer (1200, 1);
			model.timerCallback = onTimerComplete;
			model.previewTimer.addEventListener (TimerEvent.TIMER_COMPLETE, onTimerComplete);
			model.previewTimer.start();
			
		}		
		
		private function onTimerComplete (event:TimerEvent) :void {
			TweenLite.to (mirror, 0.5, {alpha:1});
		}
	}

}