package com.la.mvc.controller.match.attack 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PassiveAttackForSeveralTargets extends Command 
	{
		
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		public var asset:Sprite; 
		private var animationCof:int = 0;
		
		[Inject (name='appConsole')]
		public var console:Console; 
			
		
		override public function execute():void 
		{
			
			console.debug ('PassiveAttackForSeveralTargets::execute');
			
			var initiator:DisplayObject = event.data.initiator; 
			var target:DisplayObject;
			
			var startPosition:Point = new Point (initiator.x, initiator.y);
			startPosition = initiator.parent.localToGlobal (startPosition); 
			
			console.debug ('targets.length: ' + event.data.targets.length);
			
			for (var i:int = 0; i < event.data.targets.length; i ++) {
				target = event.data.targets[i];
				console.debug (target.toString());
				
				asset = new Sprite ();
				asset.graphics.beginFill (0xFF0000, 1);
				asset.graphics.drawRect ( -5, -5, 10, 10);
				asset.graphics.endFill();
				
				asset.x = startPosition.x + (initiator.width / 2);
				asset.y = startPosition.y + (initiator.height / 2);
				
				var endPosition:Point = new Point (target.x, target.y);
				endPosition = target.parent.localToGlobal (endPosition);
				
				endPosition.x += (target.width / 2);
				endPosition.y += (target.height / 2);
				
				scene.placeCopy (asset);
				
				animationCof ++;
				TweenLite.to (asset, 0.4, { x:endPosition.x, y:endPosition.y, ease:Expo.easeIn, 
				onComplete:passiveAttackComplete,
				onCompleteParams:[asset] 
				} );
			}
		}
		
		private function passiveAttackComplete (asset:DisplayObject) :void {
			TweenLite.to (asset, 1.0, { alpha:0, onComplete:alphaComplete } );
		}
		
		private function alphaComplete () :void {
			animationCof --;
			if (!animationCof) {
				scene.endCopy();
				dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
			}
		}
		
	}

}