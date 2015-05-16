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
	public class OverloadCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='field')]
		public var field:IField;
		
		override public function execute():void 
		{
			var attachment:int = event.data.attachment;
			var client:Boolean = event.data.clientFlag;
			
			var playerPrice:int = event.data.playerPrice;
			var playerOverload:int = event.data.playerOverload;
			
			var opponentPrice:int = event.data.opponentPrice;
			var opponentOverload:int = event.data.opponentOverload;
			
			if (attachment == 0) {
				if (client) {
					field.setOverload (playerPrice, playerOverload);
				}
			}
			
			if (attachment == 1) {
				if (!client) {
					field.setOverload (opponentPrice, opponentOverload);
				}
			}
			
			if (attachment == 2) {
				if (client) {
					field.setOverload (playerPrice, playerOverload);
				} else {
					field.setOverload (opponentPrice, opponentOverload);
				}
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));  
		}		
	}

}