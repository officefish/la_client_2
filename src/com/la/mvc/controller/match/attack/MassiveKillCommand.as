package com.la.mvc.controller.match.attack 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.field.IField;
	import flash.display.DisplayObject;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MassiveKillCommand extends Command 
	{
		[Inject (name='field')]
		public var field:IField; 
		
		[Inject]
		public var event:SceneEvent;
		
		override public function execute():void 
		{
			var targets:Array = event.data.targets;
			for (var i:int = 0; i < targets.length; i ++) {
				var target:DisplayObject = targets[i].target;
				field.remove(target);
			}
			field.sortAndCenterize();
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}		
	}

}