package com.la.mvc.controller.achieves 
{
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.mvc.view.IIntro;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CloseAchievesCommand extends Command 
	{
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject] 
		public var intro:IIntro; 
		
		[Inject (name='achieves')]
		public var achieves:AchieveBrowser;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		
		override public function execute():void 
		{
			rootModel.currentState = GameState.INTRO;
			if (contextView.contains(scene as DisplayObject)) {
				contextView.removeChild (scene as DisplayObject);
			}
			contextView.removeChild (achieves as DisplayObject);
			intro.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(intro as DisplayObject);  
		}	
		
	}

}