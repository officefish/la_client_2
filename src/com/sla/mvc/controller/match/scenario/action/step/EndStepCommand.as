package com.sla.mvc.controller.match.scenario.action.step 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.service.MatchService;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EndStepCommand extends StarlingCommand 
	{
		[Inject]
		public var stateModel:StateModel;  
		
        [Inject]
		public var service:MatchService; 
		
		[Inject] 
		public var field:Field;
		
		[Inject]
		public var hand:PlayerHand;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('EndStepCommand::execute()');
			field.blockMinions();
			field.blockHero();
			field.unblockActive();
									
			if (stateModel.state == GameState.PLAYER_STEP) {
				field.disableStepButton();
				hand.stopGlowCards();
				
				
								
				service.sendMessage('end_step', {});
			}
		}
	}

}