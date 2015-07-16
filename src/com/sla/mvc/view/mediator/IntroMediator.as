package com.sla.mvc.view.mediator 
{
	import com.sla.mvc.view.intro.IIntro;
	import org.robotlegs.mvcs.StarlingMediator;
	
	import com.sla.event.IntroEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class IntroMediator extends StarlingMediator 
	{
		[Inject]
		public var intro:IIntro;
		
		override public function onRegister():void 
		{
			eventMap.mapListener(intro.asEventDispatcher, IntroEvent.SELECT_GAME, select);
			eventMap.mapListener(intro.asEventDispatcher, IntroEvent.SELECT_COLLECTION, select);
			eventMap.mapListener(intro.asEventDispatcher, IntroEvent.SELECT_HEROES, select);
			
			eventMap.mapListener(intro.asEventDispatcher, IntroEvent.COMPLETE, complete);
		}
		
		private function select (event:IntroEvent) :void {
			dispatch(event);
		}
    
		private function complete (event:IntroEvent) :void {
			//intro.destroy ();
			//if (contextView.contains(intro as DisplayObject)) contextView.removeChild(intro as DisplayObject);
			dispatch(event);
		}
	}

}