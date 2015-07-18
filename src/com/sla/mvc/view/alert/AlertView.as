package com.sla.mvc.view.alert 
{
	import feathers.controls.Alert;
	import feathers.data.ListCollection;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import feathers.controls.Button;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AlertView extends Sprite 
	{
		
		public function AlertView() 
		{
			super();
			
		}
		
		
		
		public function alertConfirm () :void {
			var button:Button = new Button();
			button.label = "Click Me";
			button.addEventListener( Event.TRIGGERED, button_triggeredHandler );
			this.addChild(button);
			
		}
		
		private function button_triggeredHandler( event:Event ):void
		{
			
}
		
		private function okButton_triggeredHandler(event:Event) :void {
			
		}
		
	}

}