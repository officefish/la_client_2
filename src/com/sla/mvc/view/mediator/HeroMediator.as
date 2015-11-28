package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.Hero;
	import org.robotlegs.mvcs.StarlingMediator;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroMediator extends StarlingMediator 
	{
		
		[Inject]
		public var field:Field;
		
		override public function onRegister():void 
		{
			addViewListener(TouchEvent.TOUCH, onTouch); 
		}
		
		private function onTouch(event:TouchEvent) :void {
			var view:DisplayObject = this.getViewComponent() as DisplayObject; 
			var hero:Hero = view as Hero;
			if (!hero) {
				return;
			}
			if (hero.block) {
				return;
			}
			var touch:Touch = event.getTouch(view, TouchPhase.BEGAN); 
			if (touch) {
				//
				if (field.leftHandBlock && field.rightHandBlock) {
					return;
				}
				if (!field.leftHandBlock && !field.rightHandBlock) {
					dispatch(new SceneEvent(SceneEvent.SELECT_PLAYER_WEAPON, {hero:hero}));
				} else {
					if (field.leftHandBlock) {
						dispatch(new SceneEvent(SceneEvent.SELECT_TARGET_FOR_HERO_ATTACK, {hero:hero, weaponIndex:1}));
					} else {
						dispatch(new SceneEvent(SceneEvent.SELECT_TARGET_FOR_HERO_ATTACK, {hero:hero, weaponIndex:0}));

					}
				}
				
				
			}
			
		}
		
	}

}