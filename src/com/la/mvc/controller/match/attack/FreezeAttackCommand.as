package com.la.mvc.controller.match.attack 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.IAttackAvailable;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FreezeAttackCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		public var asset:Sprite;
		
		override public function execute():void 
		{
			var initiator:DisplayObject = event.data.initiator;
			var target:DisplayObject = event.data.target;
			
			asset = new Sprite ();
			asset.graphics.beginFill (0x56A5EC, 1);
			asset.graphics.drawRect ( -5, -5, 10, 10);
			asset.graphics.endFill();
			
			var startPosition:Point = new Point (initiator.x, initiator.y);
			startPosition = initiator.parent.localToGlobal (startPosition);
			
			asset.x = startPosition.x + (initiator.width / 2);
			asset.y = startPosition.y + (initiator.height / 2);
			
			var endPosition:Point = new Point (target.x, target.y);
			endPosition = target.parent.localToGlobal (endPosition);
			
			endPosition.x += (target.width / 2);
			endPosition.y += (target.height / 2);
			
			scene.placeCopy (asset); 
			
			TweenLite.to (asset, 0.4, { x:endPosition.x, y:endPosition.y, ease:Expo.easeIn, onComplete:passiveAttackComplete } );
		}
		
		private function passiveAttackComplete () :void {
			TweenLite.to (asset, 1.5, { alpha:0, onComplete:alphaComplete } );
			var target:DisplayObject = event.data.target;
			(target as IAttackAvailable).activateFreeze();
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}
		
		private function alphaComplete () :void {
			scene.endCopy();
		}		
	}

}