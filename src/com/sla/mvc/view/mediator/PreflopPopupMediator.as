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
	public class PreflopPopupMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingSceneEvent.CHANGE_PREFLOP, onChange);
			addViewListener(StarlingSceneEvent.PREFLOP_INIT, onPreflopInit);
		}
		
		private function onChange (event:StarlingSceneEvent) :void {
			//MonsterDebugger.log('onChange')
			//MonsterDebugger.log(event.data.replacement);
			dispatch(new SceneEvent(SceneEvent.CHANGE_PREFLOP, event.data)); 
		}
		
		private function onPreflopInit (event:StarlingSceneEvent) :void {
			dispatch(new SceneEvent(SceneEvent.PREFLOP_INIT));
		}
	}

}