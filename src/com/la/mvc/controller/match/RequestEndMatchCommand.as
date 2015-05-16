package com.la.mvc.controller.match 
{
	import com.la.event.SceneEvent;
	import com.la.locale.Warning;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.service.MatchService;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestEndMatchCommand extends Command 
	{
		[Inject (name='field')]
		public var field:IField;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject]
		public var service:MatchService; 
	
		
		override public function execute():void 
		{
			rootModel.currentState = GameState.PLAYER_STEP; 
			scene.darken();
			field.blur();
			scene.addEventListener (SceneEvent.WARNING_CLOSE, onWarningClose);
			if (event.data.client) {
				if (event.data.playerWin) {
					scene.warning (Warning.WIN); 
				} else {
					scene.warning (Warning.LOST)
				}
			} else {
				if (event.data.opponentWin) {
					scene.warning (Warning.WIN); 
				} else {
					scene.warning(Warning.LOST);
				}
			}
			
		}	
		
		private function onWarningClose (event:SceneEvent) :void {
			// отправляем серверу запрос о наградах либо о выходе из матча
			scene.removeEventListener (SceneEvent.WARNING_CLOSE, onWarningClose);	
			service.sendMessage('end_match', {});
		}
	}

}