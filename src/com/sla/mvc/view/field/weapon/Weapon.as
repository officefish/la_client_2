package com.sla.mvc.view.field.weapon 
{
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Weapon extends Sprite 
	{
		
		private var weaponBg:Quad;
		private var powerBg:Quad;
		private var strengthBg:Quad;
		
		private var powerLabel:Label;
		private var strengthLabel:Label;
		
		private var id:int;
		private var power:int;
		private var _strength:int;
		
		public function Weapon(id:int, power:int, strength:int) 
		{
			this.id = id;
			this.power = power;
			this._strength = strength;
			this.touchable = true;
			
			var platform:Sprite = new Sprite();
			addChild(platform);
			
			platform.x -= 35;
			platform.y -= 35;
			addChild(platform);
			
			weaponBg = new Quad(70, 70, 0x555555);
			platform.addChild(weaponBg);
			
			powerBg = new Quad(20, 20, 0xFFFFFF);
			powerBg.y = 49;
			powerBg.x = 1;
			powerBg.touchable = false;
			platform.addChild(powerBg);
			
			strengthBg =  new Quad(20, 20, 0xFFFFFF);
			strengthBg.y = 49;
			strengthBg.x = 49;
			strengthBg.touchable = false;
			platform.addChild(strengthBg);
			
			powerLabel = new Label();
			powerLabel.width = 20;
			powerLabel.y = 50;
			powerLabel.styleNameList.add("weaponLabel");
			platform.addChild(powerLabel);
			powerLabel.touchable = false;
			powerLabel.text = power.toString();
			
			strengthLabel = new Label();
			strengthLabel.width = 20;
			strengthLabel.y = 50;
			strengthLabel.x = 50;
			strengthLabel.styleNameList.add("weaponLabel");
			platform.addChild(strengthLabel);
			strengthLabel.touchable = false;
			strengthLabel.text = strength.toString();
			
			
		}
		
		public function strength (value:int) :void {
			this._strength = value;
			strengthLabel.text = value.toString();
		}
		
		public function glow () :void {
			this.filter = glowFilter;
		}
		
		public function stopGlow () :void {
			this.filter = null;
		}
		private static var _glowWilter:BlurFilter;  
		private static function get glowFilter () :BlurFilter {
			if (!_glowWilter) {
				_glowWilter = BlurFilter.createGlow(0x00FFFF, 1, 3, .5);
			}
			return _glowWilter;
		}
		
		public function clone () :Weapon {
			var weapon:Weapon = new Weapon(id, power, _strength);
			return weapon;
		}
		
	}

}