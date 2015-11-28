package com.sla.mvc.view.field 
{
	import flash.geom.Point;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldAbilityManaWidget extends Sprite 
	{
		private var radioSlots:Vector.<AbilityRadio>
		private var radioStack:Sprite;
		private static var radius:int = 38;
		
		public function FieldAbilityManaWidget(price:int, playerFlag:Boolean) 
		{
			radioStack = new Sprite;
			radioStack.x = FieldAbilityManaWidget.radius;
			radioStack.y = FieldAbilityManaWidget.radius;
			addChild(radioStack);
			
			//if (!playerFlag) price = 9;
			
			radioSlots = new Vector.<AbilityRadio> (); 
			var radio:AbilityRadio;
			for (var i:int = 0; i < price; i ++) {
				radio = new AbilityRadio();
				if (playerFlag) {
					radio.x = FieldAbilityManaWidget.playerRadioPositions[i].x;
					radio.y = FieldAbilityManaWidget.playerRadioPositions[i].y;
				} else {
					radio.x = FieldAbilityManaWidget.opponentRadioPositions[i].x;
					radio.y = FieldAbilityManaWidget.opponentRadioPositions[i].y;
				}
				radioSlots.push(radio);
				radioStack.addChild(radio);
			}
		}
		
		public function increment (price:int) :void {
			var radio:AbilityRadio;
			for (var i:int = 0; i < price; i ++) {
				radio = radioSlots[i];
				radio.enable();
			}
		}
		
		public function disable () :void {
			var radio:AbilityRadio;
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