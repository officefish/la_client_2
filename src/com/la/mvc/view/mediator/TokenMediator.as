package com.la.mvc.view.mediator 
{
	import com.la.event.TokenEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.IToken;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class TokenMediator extends Mediator
	{
		
		[Inject (name='rootModel')]
		public var rootModel:RootModel;
				
		[Inject]
		public var token:IToken;
		
		[Inject (name='appConsole')]
		public var console:Console;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (names = 'matchModel')]
		public var model:MatchModel; 
		
		override public function onRegister():void 
		{
			//contextView.stage.addEventListener (MouseEvent.MOUSE_DOWN, onStageMouseDown);
			eventMap.mapListener (token, MouseEvent.MOUSE_DOWN, mouseDown);
			eventMap.mapListener (token, MouseEvent.MOUSE_OVER, onMouseOver);
			eventMap.mapListener (token, MouseEvent.MOUSE_OUT, onMouseOut); 
		}
		
		private function mouseDown (event:MouseEvent) :void {
			var token:IToken = event.target as IToken;
			if (!token.canAttack) return;
			if (rootModel.currentState != GameState.PLAYER_STEP) return;
			
			
			dispatch (new TokenEvent (TokenEvent.ATTACK, token));
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			if (token.cloneFlag) return;
			if (token.isPreview) return;
			dispatch (new TokenEvent (TokenEvent.PREVIEW, token));
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			if (token.cloneFlag) return;
			if (token.isPreview) return;
			scene.endPreview(); 
			if (model.previewTimer) {
				model.previewTimer.removeEventListener (TimerEvent.TIMER_COMPLETE, model.timerCallback);
				model.previewTimer.stop();
			}
		}
	}

}