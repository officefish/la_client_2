package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.event.SceneEvent;
	import com.sla.event.starling.StarlingFieldEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.minion.IMinion;
	import org.robotlegs.mvcs.StarlingMediator;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MinionMediator extends StarlingMediator 
	{
		[Inject]
		public var matchModel:MatchModel;
		
		override public function onRegister():void 
		{
			addViewListener(TouchEvent.TOUCH, onTouch); 
			addViewListener(StarlingFieldEvent.WIDGET_ACTIVATE, onWidgetActivate);
		}	
		
		private function onWidgetActivate () :void {
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
		private function onTouch (event:TouchEvent) :void {
			
			var view:DisplayObject = this.getViewComponent() as DisplayObject; 
			var minion:IMinion = view as IMinion;
			if (!minion) {
				return;
			}
			if (minion.isEnemy || minion.block) {
				return;
			}
			var touch:Touch = event.getTouch(view, TouchPhase.BEGAN);
			if (touch) {
				if (minion.hasActiveAptitude && minion.activeManacost <= matchModel.mana && minion.activeBlock == false) {
					dispatch (new SceneEvent(SceneEvent.ACTION_POPUP, { minion:minion } ));
				} else {
					dispatch(new SceneEvent(SceneEvent.INIT_ATTACK_TARGET, { minion:minion } ));
				}
				
			}
		}
	}

}