package com.sla.mvc.controller.ability 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilitiesInitCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject]
		public var browser:AbilityBrowser; 
		
		[Inject]
		public var model:HeroModel;
		
		
		override public function execute():void 
		{
			MonsterDebugger.log ('AbilitiesInitCommand');
			
			browser.initHero(event.data.heroVocation);
			model.heroId = event.data.heroId;
			browser.initAbilities(event.data.achieves);
			browser.setup(event.data.setup);
		}
		
	}

}