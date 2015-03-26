package com.la.mvc.controller.loading 
{
	import com.la.locale.Warning;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreloadingCommand extends Command 
	{
		
		[Inject (name='scene')]
		public var scene:IScene;   
		
		override public function execute():void 
		{
			contextView.addChild(scene as DisplayObject);
			scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.darken();
			scene.block();
			scene.warning (Warning.PRELOADING);
		}		
	}

}