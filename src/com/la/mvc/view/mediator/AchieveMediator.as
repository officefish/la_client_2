package com.la.mvc.view.mediator 
{
	import com.la.event.AchieveEvent;
	import com.la.event.HeroesEvent;
	import com.la.mvc.model.HeroModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveMediator extends Mediator 
	{
		
		[Inject (name = 'achieves')]
		public var achieves:AchieveBrowser;
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
				
		[Inject (name='heroModel')]
		public var model:HeroModel; 
		
		override public function onRegister():void { 
			eventMap.mapListener(achieves, HeroesEvent.SELECT_HERO, listener);
			eventMap.mapListener(achieves, AchieveEvent.SAVE, achieveListener);
			eventMap.mapListener(achieves, AchieveEvent.CLOSE, achieveListener);
			eventMap.mapListener(achieves, AchieveEvent.CREATE, achieveListener);
			eventMap.mapListener(achieves, AchieveEvent.CLOSE_CRAFT, onCloseCraft);
			eventMap.mapListener(achieves, AchieveEvent.READY_CRAFT, onReadyCraft);
		}
		
		public function onCloseCraft(event:AchieveEvent) :void {
			if (rootModel.currentState == GameState.HEROES) {
				dispatch(new AchieveEvent(AchieveEvent.CLOSE));
			}
		}
		
		public function onReadyCraft(event:AchieveEvent) :void {
			if (rootModel.currentState == GameState.HEROES) {
				dispatch(new HeroesEvent(HeroesEvent.SELECT_HERO, {'hero_id':model.heroId}));
			}
		}
		
		private function listener(event:HeroesEvent) :void {
			dispatch(event);
		}
		
		private function achieveListener(event:AchieveEvent) :void {
			dispatch(event);
		}
	
	}

}