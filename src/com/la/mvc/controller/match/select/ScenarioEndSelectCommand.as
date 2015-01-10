package com.la.mvc.controller.match.select 
{
	import com.la.event.ScenarioEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.scene.IScene;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ScenarioEndSelectCommand extends Command 
	{
		
		[Inject (name='field')]
		public var field:IField;
				
		[Inject (name='scene')] 
		public var scene:IScene; 
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name = 'matchModel')]
		public var matchModel:MatchModel; 
		
		override public function execute():void 
		{
			scene.stopStepTimer();
			contextView.stage.removeEventListener (MouseEvent.CLICK, matchModel.selectListener);
			scene.endCopy();
			scene.lighten(false);
			field.stopBlur();
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}
		
	}

}