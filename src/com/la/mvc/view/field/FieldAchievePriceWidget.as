package com.la.mvc.view.field 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldAchievePriceWidget extends Sprite 
	{
		
		private var radioSlots:Vector.<AchieveRadio>
		private var radioStack:Sprite;
		private static var radius:int = 38;
		
		public function FieldAchievePriceWidget(price:int, playerFlag:Boolean = true) 
		{
			radioStack = new Sprite;
			radioStack.x = FieldAchievePriceWidget.radius;
			radioStack.y = FieldAchievePriceWidget.radius;
			addChild(radioStack);
			
			//if (!playerFlag) price = 9;
			
			radioSlots = new Vector.<AchieveRadio> ();
			var radio:AchieveRadio;
			for (var i:int = 0; i < price; i ++) {
				radio = new AchieveRadio();
				if (playerFlag) {
					radio.x = FieldAchievePriceWidget.playerRadioPositions[i].x;
					radio.y = FieldAchievePriceWidget.playerRadioPositions[i].y;
				} else {
					radio.x = FieldAchievePriceWidget.opponentRadioPositions[i].x;
					radio.y = FieldAchievePriceWidget.opponentRadioPositions[i].y;
				}
				radioSlots.push(radio);
				radioStack.addChild(radio);
			}
		}
		
		public function increment (price:int) :void {
			var radio:AchieveRadio;
			for (var i:int = 0; i < price; i ++) {
				radio = radioSlots[i];
				radio.enable();
			}
		}
		
		public function disable () :void {
			var radio:AchieveRadio;
			for (var i:int = 0; i < radioSlots.length; i ++) {
				radio = radioSlots[i];
				radio.disable();
			}
		}
		
		private static var _playerRadioPositions:Vector.<Point>; 
		private static function get playerRadioPositions () :Vector.<Point> {
			if (!_playerRadioPositions) {
				_playerRadioPositions = new Vector.<Point>();
				_playerRadioPositions.push (new Point(Math.cos(150 * Math.PI / -180) * radius, Math.sin(150 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(135 * Math.PI / -180) * radius, Math.sin(135 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(120 * Math.PI / -180) * radius, Math.sin(120 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(105 * Math.PI / -180) * radius, Math.sin(105 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(90 * Math.PI / -180) * radius, Math.sin(90 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(75 * Math.PI / -180) * radius, Math.sin(75 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(60 * Math.PI / -180) * radius, Math.sin(60 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(45 * Math.PI / -180) * radius, Math.sin(45 * Math.PI / -180) * radius));
				_playerRadioPositions.push (new Point(Math.cos(30 * Math.PI / -180) * radius, Math.sin(30 * Math.PI / -180) * radius));

			}
			return _playerRadioPositions;
		}
		
		private static var _opponentRadioPositions:Vector.<Point>; 
		private static function get opponentRadioPositions () :Vector.<Point> {
			if (!_opponentRadioPositions) {
				_opponentRadioPositions = new Vector.<Point>();
				_opponentRadioPositions.push (new Point(Math.cos(210 * Math.PI / -180) * radius, Math.sin(210 * Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(225 * Math.PI / -180) * radius, Math.sin(225 * Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(240 * Math.PI / -180) * radius, Math.sin(240 * Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(255 * Math.PI / -180) * radius, Math.sin(255 * Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(270* Math.PI / -180) * radius, Math.sin(270 * Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(285 * Math.PI / -180) * radius, Math.sin(285 * Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(300 * Math.PI / -180) * radius, Math.sin(300 * Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(315 * Math.PI / -180) * radius, Math.sin(315* Math.PI / -180) * radius));
				_opponentRadioPositions.push (new Point(Math.cos(330 * Math.PI / -180) * radius, Math.sin(330 * Math.PI / -180) * radius));

			}
			return _opponentRadioPositions;
		}
		
	}

}