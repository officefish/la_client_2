package com.la.mvc.view.mediator 
{
	import com.la.event.HeroesEvent;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveMediator extends Mediator 
	{
		
		[Inject (name = 'achieves')]
		public var achieves:AchieveBrowser;
		
		override public function onRegister():void { 
			eventMap.mapListener(achieves, HeroesEvent.SELECT_HERO, listener);
		}
		
		private function listener(event:HeroesEvent) :void {
			dispatch(event);
		}
	
	}

}