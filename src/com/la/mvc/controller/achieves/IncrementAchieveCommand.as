package com.la.mvc.controller.achieves 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.field.FieldAchieveSlot;
	import com.la.mvc.view.field.IField;
	import flash.events.Event;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class IncrementAchieveCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='field')]
		public var field:IField; 
		
		override public function execute():void 
		{
			var position:int = event.data.position;
			var increment:int = event.data.increment;
			var client:Boolean = event.data.client;
			var enable:Boolean = event.data.enable;
			var achieve:FieldAchieveSlot = field.getAchieveSlot(position, client);
			achieve.increment(increment);
			if (enable) {
				achieve.enable();
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
			
			
		}	
	}

}