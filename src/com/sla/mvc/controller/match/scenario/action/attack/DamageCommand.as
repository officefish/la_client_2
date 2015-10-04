package com.sla.mvc.controller.match.scenario.action.attack 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.field.damage.Damage;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DamageCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('DamageCommand::execute()');
			super.execute();
			
			var targets:Array = event.data.targets;
			var client:Boolean = event.data.client;
			var targetData:Object;
			var index:int;
			var attachment:int;
			var position:Point;
			var minion:IMinion;
			var damage:Damage;
			var timeline:TimelineMax = new TimelineMax();
			timeline.pause();
			timeline.add('spin');
			for (var i:int = 0; i < targets.length; i ++) {
				targetData = targets[i];
				index = targetData.index;
				attachment = targetData.attachment;
				minion = getTarget(index, attachment, client);
				position = minion.globalPosition;
				damage = new Damage(targetData.damage); 
				damage.x = position.x;
				damage.y = position.y;
				scene.addDamage(damage);
				timeline.to (damage, 2.0, { alpha:0, delay:0.5, ease:Expo.easeOut,
				onComplete:onTweenComplete,  onCompleteParams:[damage] }, 'spin')
				
			}
			timeline.play();
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		private function onTweenComplete (damage:DisplayObject) :void {
			if (damage.parent) {
				damage.parent.removeChild(damage);
			}
		}
	}

}