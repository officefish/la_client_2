package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.event.starling.StarlingCardEvent;
	import com.sla.mvc.view.card.PreflopCard;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreflopCardMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingCardEvent.PREFLOP_CLICK, onClick);
		}
		private function onClick (event:StarlingCardEvent) :void {
			if ((viewComponent as PreflopCard).isBlocked) {
				return;
			}
			dispatch(new SceneEvent(SceneEvent.PREFLOP_CLICK, event.data));
		}
	}

}