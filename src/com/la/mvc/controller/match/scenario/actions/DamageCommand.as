package com.la.mvc.controller.match.scenario.actions 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.damage.Damage;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DamageCommand extends Command 
	{
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject]
		public var event:SceneEvent;
		
		override public function execute():void 
		{
			for (var i:int = 0; i < event.data.targets.length; i ++) {
				var targetData:Object = event.data.targets[i];
				var target:DisplayObject = targetData.target;
				var position:Point = new Point(target.x, target.y);
				position = target.parent.localToGlobal(position);
				position.x += target.width / 2;
				position.y += target.height / 2;
				var damage:Damage = new Damage(targetData.damage);
				damage.x = position.x;
				damage.y = position.y;
				scene.addDamage(damage);
				TweenLite.to (damage, 1.0, { alpha:0, delay:1.0, ease:Expo.easeOut, 
				onComplete:onTweenComplete,  onCompleteParams:[damage] })
				
			}
			
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
		private function onTweenComplete (damage:Sprite) :void { 
			if (damage.parent) {
				damage.parent.removeChild(damage);
			}
		}
	}

}