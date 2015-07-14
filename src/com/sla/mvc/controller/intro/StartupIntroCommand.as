package com.sla.mvc.controller.intro {
	import com.sla.mvc.view.intro.IIntro;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupIntroCommand extends StarlingCommand 
	{
		[Inject]
		public var intro:IIntro;
		
		override public function execute():void 
		{
			super.execute();
			MonsterDebugger.log ("StartupIntroCommand::execute()");
			
			intro.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(intro.asStarlingSprite);
			
			MonsterDebugger.log(contextView);
		}		
	}

}