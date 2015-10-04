package com.sla.mvc.controller.match.scenario.action.attack 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.animation.Animation;
	import com.sla.mvc.view.animation.DemoTargetInitiatorAnimation;
	import com.sla.mvc.view.animation.ITargetInitiatorAnimation;
	import com.sla.mvc.view.animation.spell.ice.Frostbolt;
	import com.sla.mvc.view.animation.TargetInitiatorAnimation;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PassiveAttackCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var scene:Scene;
		
		private var _frostbolt:ITargetInitiatorAnimation;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('PassiveAttackCommand::execute()');
			var client:Boolean = event.data.client;
			var initiator:IMinion = getTarget(event.data.initiatorIndex, event.data.initiatorAttachment, client);
			var target:IMinion = getTarget(event.data.targetIndex, event.data.targetAttachment, client);
			
			if (!target.asDO()) {
				MonsterDebugger.log ('WARNING. Target not init in PassiveAttackCommand. Command ignore!')
				dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			}
			if (!initiator.asDO()) {
				MonsterDebugger.log ('WARNING. Initiator not init in PassiveAttackCommand. Command ignore!')
				dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			}
			var animation:ITargetInitiatorAnimation;
			if (event.data.animation) {
				animation = getAnimation(event.data.animation)
			} else {
				animation = new DemoTargetInitiatorAnimation();
			}
			
			//scene.darken();
			animation.configure(Animation.scene,initiator.globalPosition, target.globalPosition, onComplete);
			animation.start();
			
		}
		
		protected function getAnimation (type:int) :ITargetInitiatorAnimation {
			var animation:ITargetInitiatorAnimation = new DemoTargetInitiatorAnimation(); 
			switch (type) {
				case 1: {
					if (_frostbolt == null) {
						_frostbolt = new Frostbolt();
						_frostbolt.init();
					}
					animation = _frostbolt;
					break;
				}
			}
			
			return animation;
		}
		
		protected function onComplete () :void {
			//scene.removeDarken();
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
		
	}

}