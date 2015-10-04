package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.event.starling.StarlingSceneEvent;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SceneMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingSceneEvent.WELCOME_COMPLETE, onWelcomeComplete);
		}
		
		private function onWelcomeComplete (event:StarlingSceneEvent) :void {
			dispatch(new SceneEvent(SceneEvent.WELCOME_COMPLETE));
		}
	}

}