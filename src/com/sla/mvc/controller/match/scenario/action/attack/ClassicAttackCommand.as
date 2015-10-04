package com.sla.mvc.controller.match.scenario.action.attack 
{
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.field.minion.Minion;
	import com.sla.mvc.view.field.MinionPosition;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ClassicAttackCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		private var inicitiatorMinion:IMinion;
		private var targetMinion:IMinion;
		
		[Inject]
		public var scene:Scene;
		
		[Inject]
		public var model:MatchModel;
		
		override public function execute():void 
		{
			super.execute();
			inicitiatorMinion = getTarget(event.data.initiatorIndex, 1, event.data.client);
			targetMinion = getTarget(event.data.targetIndex, 0, event.data.client);
			
			model.attackMinion = inicitiatorMinion;
			
			if (!event.data.client) {
				inicitiatorMinion.asDO().scaleX = inicitiatorMinion.asDO().scaleY = 1.1;
			}
			
			inicitiatorMinion.asDO().visible = false;
			var iniciatorMinionCopy:IMinion = inicitiatorMinion.clone();
			inicitiatorMinion.copy = iniciatorMinionCopy;
			iniciatorMinionCopy.dropShadow();
			
			iniciatorMinionCopy.asDO().scaleX = iniciatorMinionCopy.asDO().scaleY = 1.1;
			iniciatorMinionCopy.asDO().x = inicitiatorMinion.globalPosition.x;
			iniciatorMinionCopy.asDO().y = inicitiatorMinion.globalPosition.y;
			scene.addMinion(iniciatorMinionCopy.asDO());
			
			var endPosition:Point = targetMinion.globalPosition;
			if (event.data.client) {
				endPosition.y += Minion.HEIGHT / 2;
			} else {
				endPosition.y -= Minion.HEIGHT / 2;
			}
			TweenLite.to(iniciatorMinionCopy, .2, { x:endPosition.x, y:endPosition.y, ease:Expo.easeIn, onComplete:onComplete } );
			
			//inicitiatorMinion.asDO().y -= 50;
			//targetMinion.asDO().y -= 50;
			
		}
		
		private function onComplete () :void {
			field.shake(inicitiatorMinion.attackValue);
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}