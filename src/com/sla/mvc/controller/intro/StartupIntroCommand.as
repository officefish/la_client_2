package com.sla.mvc.controller.intro {
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.intro.Intro;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupIntroCommand extends StarlingCommand 
	{
		[Inject]
		public var intro:Intro;
		
		[Inject]
		public var stateModel:StateModel;
		
		override public function execute():void 
		{
			super.execute();
			MonsterDebugger.log ("StartupIntroCommand::execute()");
			
			intro.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(intro);
			
			//MonsterDebugger.log(contextView);
		}		
	}

}