package com.sla.mvc.view.mediator 
{
	import com.sla.event.IntroEvent;
	import starling.events.Event;
	import org.robotlegs.mvcs.StarlingMediator;
	
	import com.sla.event.starling.StarlingIntroEvent;
	
	import com.demonsters.debugger.MonsterDebugger
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class IntroMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			//MonsterDebugger.log("onRegister");
			//intro.asStarlingSprite.addEventListener(Event.TRIGGERED, select);
			//eventMap.mapStarlingListener(intro.asStarlingSprite, Event.TRIGGERED, select);
			addViewListener(StarlingIntroEvent.SELECT_GAME, selectGame);
			addViewListener(StarlingIntroEvent.SELECT_COLLECTION, selectCollection);
			addViewListener(StarlingIntroEvent.SELECT_HEROES, selectHeroes);
			addViewListener(StarlingIntroEvent.COMPLETE, complete);
		}
		
		private function selectGame (event:StarlingIntroEvent) :void { 
			dispatch (new IntroEvent(IntroEvent.SELECT_GAME));
			//MonsterDebugger.log ("selectGame");
			//dispatch(event);
			
		}
		
		private function selectCollection (event:StarlingIntroEvent) :void { 
			dispatch (new IntroEvent(IntroEvent.SELECT_COLLECTION));
			//MonsterDebugger.log ("selectCollection");
			//dispatch(event);
			
		}
		
		private function selectHeroes (event:StarlingIntroEvent) :void {
			dispatch (new IntroEvent(IntroEvent.SELECT_HEROES));
			//MonsterDebugger.log ("selectHeroes");
		}
    
		private function complete (event:StarlingIntroEvent) :void {
			dispatch (new IntroEvent(IntroEvent.COMPLETE));
			//intro.destroy ();
			//if (contextView.contains(intro as DisplayObject)) contextView.removeChild(intro as DisplayObject);
			//dispatch(event);
		}
	}

}