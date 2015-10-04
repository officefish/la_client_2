package com.sla.mvc.controller.match.scenario.action.attack 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AttackCompleteCommand extends StarlingCommand
	{
		[Inject]
		public var model:MatchModel;
		
		[Inject]
		public var scene:Scene;
		
		private var minion:IMinion;
		private var minionCopy:IMinion;
		
		[Inject]
		public var field:Field;
		
		override public function execute():void 
		{
			//new MonsterDebugger.log ('AttackCompleteCommand::execute()');
			minion = model.attackMinion;
			minionCopy = minion.copy;
			
			TweenLite.to(minionCopy.asDO(), 0.5, { x:minion.globalPosition.x, y:minion.globalPosition.y, ease:Expo.easeOut, onComplete:onComplete } );
		}
		
		private function onComplete () :void {
			minion.asDO().visible = true;
			scene.removeAllMinions();
			minion.canAttack = false;
			minion.block = true;
			minion.stopDropShadow();
			minion.asDO().scaleX = minion.asDO().scaleY = 1; 
			field.glowMinions();
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}