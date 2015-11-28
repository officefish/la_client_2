package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionHeroesInitCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject]
		public var collection:Collection;
		
		[Inject]
		public var stateModel:StateModel;
		
		[Inject]
		public var abilityBrowser:AbilityBrowser;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('CollectionHeroesInitCommand::execute()');

			if (stateModel.state == GameState.HEROES) {
				abilityBrowser.initHeroes(event.data.heroes)
			} else {
				collection.initHeroes (event.data.heroes);
			}
		}
		
		
	}

}