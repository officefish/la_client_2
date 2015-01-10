package com.la.mvc.controller.match.step 
{
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.MatchService;
	import com.la.mvc.view.field.IField;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EndStepCommand extends Command 
	{
		[Inject (name='rootModel')]
		public var rootModel:RootModel; 
		
        [Inject]
		public var service:MatchService; 
		
		[Inject (name='field')] 
		public var field:IField;
		
		override public function execute():void 
		{
			field.blockTokens ();
			
			if (rootModel.currentState == GameState.PLAYER_STEP) {
				 service.sendMessage('end_step', {});
			}
		}
	}

}