package com.sla.mvc.controller.match.scenario.action.attack 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.field.minion.IMinion;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AttackMixinCommand extends MinionActionCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('AttackMixinCommand::execute()');
			var client:Boolean = event.data.client;
			var target:IMinion = getTarget(event.data.index, event.data.attachment, client); 
			var attackBob:int = target.getAttackBob();
			attackBob += event.data.power;
			target.setAttackBob (attackBob);
			target.setAttack(target.getAttack());
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}	
	}

}