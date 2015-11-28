package com.sla.mvc.controller.plreloader 
{
	import com.sla.mvc.view.preloader.Preloader;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreloadCommand extends StarlingCommand 
	{
		[Inject]
		public var preloader:Preloader;
		
		override public function execute():void 
		{
			preloader.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			contextView.addChild(preloader);
		}
		
	}

}