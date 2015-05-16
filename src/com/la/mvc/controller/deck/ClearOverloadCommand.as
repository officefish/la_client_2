package com.la.mvc.controller.deck 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.field.IField;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ClearOverloadCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='field')]
		public var field:IField; 
		
		override public function execute():void 
		{
			var client:Boolean = event.data.clientFlag;
			if (client) {
				field.clearOverload();
			}
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));  
		}		
	}

}