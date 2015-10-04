package com.sla.mvc.view.animation 
{
	import com.greensock.easing.Expo;
	import com.greensock.easing.Power0;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DemoTargetInitiatorAnimation extends TargetInitiatorAnimation 
	{
		
		private var clip:Sprite;
				
		override public function start():void 
		{
			if (!clip) {
				clip = new Sprite();
				var quad:Quad = new Quad(10, 10, 0xFF0000);
				quad.x = quad.y = -5;
				clip.addChild(quad);
			} else {
				clip.alpha = 1;
			}
			
			clip.x = initiatorPosition.x;
			clip.y = initiatorPosition.y;
			
			scene.addChild(clip);
			
			TweenLite.to (clip, 0.5, { x:targetPosition.x, y:targetPosition.y, ease:Expo.easeOut, onComplete:onTweenComplete } );
		}
		
		private function onTweenComplete () :void {
			TweenLite.to (clip, 0.5, { alpha:0, ease:Power0.easeNone, onComplete:onAlphaComplete } );
			onComplete();
		}
		
		private function onAlphaComplete () :void {
			scene.removeChild(clip);
		}
		
		
		
	}

}