package com.sla.mvc.controller.match.startup {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.MatchEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupMatchCommand extends StarlingCommand 
	{
		
		[Inject]
		public var field:Field;
		
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			MonsterDebugger.log('StartupMatchCommand::execute()');
			
			contextView.removeChildren();
			
			field.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(field);
			
			scene.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.darken();
			contextView.addChild(scene);
			
			dispatch(new MatchEvent(MatchEvent.STARTUP_COMPLETE));
			
		}
		
	}

}