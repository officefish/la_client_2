package com.sla.mvc.controller.match.scenario.action.simple 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class GlowHeroCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero;
		
		[Inject]
		public var field:Field;
		
		
		
		override public function execute():void 
		{
			MonsterDebugger.log ('GlowHeroCommand::execute()');
			if (event.data.client) {
				if (field.leftHandBlock && field.rightHandBlock) {
					playerHero.block = true;
					playerHero.stopGlow();
					dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
				} else {
					playerHero.block = false;
					playerHero.glow();
				}
				
			} 
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
	}

}