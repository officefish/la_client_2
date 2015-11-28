package com.sla.mvc.controller.ability 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.IntroEvent;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CompleteSetupAbilitiesCommand extends StarlingCommand 
	{
		
		[Inject]
		public var stateModel:StateModel; 
		
		[Inject]
		public var browser:AbilityBrowser; 
				
		
		override public function execute():void 
		{
			MonsterDebugger.log ('CompleteSetupAilitiesCommand');
			browser.clear ();
			stateModel.state = GameState.INTRO; 
			dispatch (new IntroEvent(IntroEvent.STARTUP));
		
		}
		
	}

}