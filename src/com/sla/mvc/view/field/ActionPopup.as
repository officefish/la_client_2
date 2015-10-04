package com.sla.mvc.view.field 
{
	import com.sla.mvc.view.lobby.ModePopup;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ActionPopup 
	{
		
		public function ActionPopup() 
		{
			
		}
		
		private static var _attackButton:PopupButton;
		public static function get attackButton () :PopupButton {
			if (!_attackButton) {
				_attackButton = new PopupButton('Attack');
			}
			return _attackButton;
		}
		
		private static var _aptitudeButton:PopupButton;
		public static function get aptitudeButton () :PopupButton {
			if (!_aptitudeButton) {
				_aptitudeButton = new PopupButton('Aptitude');
			}
			return _aptitudeButton;
		}
		
		
		
	}

}