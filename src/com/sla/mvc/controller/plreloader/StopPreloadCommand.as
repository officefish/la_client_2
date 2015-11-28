package com.sla.mvc.controller.plreloader 
{
	import com.sla.mvc.view.preloader.Preloader;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StopPreloadCommand extends StarlingCommand 
	{
		[Inject]
		public var preloader:Preloader; 
		
		override public function execute():void 
		{
			if (contextView.contains(preloader)) contextView.removeChild(preloader);
		}		
	}

}