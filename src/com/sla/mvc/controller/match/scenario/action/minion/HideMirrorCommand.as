package com.sla.mvc.controller.match.scenario.action.minion 
{
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HideMirrorCommand extends StarlingCommand 
	{
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			scene.hidePreview();
		}	
	}

}