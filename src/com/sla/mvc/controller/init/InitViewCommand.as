package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import com.sla.mvc.view.animation.Animation;
	import com.sla.mvc.view.scene.Scene;
	import com.sla.theme.LastArgumentTheme;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;  
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitViewCommand extends StarlingCommand 
	{
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			super.execute();
			
			// init main theme
			new LastArgumentTheme ();
			
			// init container for animations
			Animation.scene = scene.getAnimationLevel();
			
			MonsterDebugger.log("InitViewCommand::execute()");
			dispatch(new LAContextEvent(LAContextEvent.VIEW_INIT)); 
		}		
	}

}