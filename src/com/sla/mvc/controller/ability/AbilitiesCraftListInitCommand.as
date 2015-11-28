package com.sla.mvc.controller.ability {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.state.GameState;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilitiesCraftListInitCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject]
		public var browser:AbilityBrowser; 
		
		[Inject]
		public var model:CollectionModel; 
		
		[Inject]
		public var stateModel:StateModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('AbilitiesCraftListInitCommand::execute()');
			MonsterDebugger.log (event.data.abilities);
			stateModel.state = GameState.CRAFT_ABILITY;
			browser.initCraftAbilities(event.data.abilities);
			//achieves.initCraftAchieves(event.getData()['achieves'])
			model.dust = event.data.dust;
			browser.setDust (event.data.dust);
		}
		
	}

}