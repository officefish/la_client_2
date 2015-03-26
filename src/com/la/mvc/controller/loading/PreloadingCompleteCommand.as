package com.la.mvc.controller.loading 
{
	import com.la.mvc.view.scene.IScene;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreloadingCompleteCommand extends Command 
	{
		[Inject (name='scene')]
		public var scene:IScene;   
				
		override public function execute():void 
		{
			scene.lighten(false);
			scene.stopWarning();
			scene.stopBlock();
		}		
	}

}