package com.sla.mvc.view.lobby 
{
	import com.sla.event.starling.ModePopupEvent;
	import feathers.controls.Alert;
	import feathers.controls.Icon;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ModePopup extends Panel 
	{
		
		private static var instance:ModePopup;
		private static var _callback:Function;
		
		public function ModePopup() 
		{
			this.title = "Select game mode!";
			this.styleNameList.add('modePopupPanel');
			this.customHeaderStyleName = Alert.DEFAULT_CHILD_STYLE_NAME_HEADER;
			var xPosition:Number = 0;
			for(var i:int = 0; i < 3; i++)
			{
				var block:ModeBlock = new ModeBlock(i, getModeTitle(i), getModeDescription(i));
				block.addEventListener(ModePopupEvent.SELECT, onModeSelect);
				block.x = xPosition;
				addChild(block);
				xPosition += 250;
			}
		}
		
		private function getModeTitle (index:int) :String {
			var str:String;
			switch (index) {
				case 0: {
					str = 'Sprint';
					break;
				}
				case 1: {
					str = 'Regular';
					break;
				}
				case 2: {
					str = 'Control';
					break;
				}
			}
			return str;
		}
		
		private function getModeDescription (index:int) :String {
			var str:String;
			switch (index) {
				case 0: {
					str = 'In Sprint mode you and your opponent get 2 new cards from deck every step. You can use only one hero achieve.';
					break;
				}
				case 1: {
					str = 'In Regular mode you and your opponent get 1 new card from deck. You can use 2 hero achieves.';
					break;
				}
				case 2: {
					str = 'In Control mode you and your opponent get 1 new card from deck. You can use 4 acheves. You can control which card should your pick next time.';
					break;
				}
			}
			return str;
		}
		
		private function onModeSelect(event:ModePopupEvent) :void {
			var index:int = event.data.index;
			ModePopup._callback(index);
			PopUpManager.removePopUp(instance);
		}
		
		public static function init (callback:Function) :void {
			if (instance == null) {
				instance = new ModePopup();
			}
			_callback = callback;
		}
		
		public static function show () :void {
			PopUpManager.addPopUp(instance, true, true); 
		}
		
	}

}