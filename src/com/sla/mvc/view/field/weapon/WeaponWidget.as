package com.sla.mvc.view.field.weapon {
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class WeaponWidget extends Sprite 
	{
		private var weaponSprite:Sprite;
		private var bgQuad:Quad;
		
		private var weaponContainer:Sprite;
		private var weapon:Weapon;
		
		private var _blockFlag:Boolean = false;
		
		public function WeaponWidget() 
		{
			var bgQuad:Quad = new Quad(60, 60, 0xAAAAAA);
			bgQuad.x -= 30;
			bgQuad.y -= 30;
			addChild(bgQuad);
			
			weaponContainer = new Sprite();
			addChild(weaponContainer);
		}
		
		public function addWeapon (weapon:Weapon) :void {
			this.weapon = weapon;
			weaponContainer.removeChildren();
			weaponContainer.addChild(weapon);
		}
		
		public function getWeapon () :Weapon {
			return weapon;
		}
		
		public function containsWeapon (weapon:Weapon) :Boolean {
			return weaponContainer.contains(weapon);
		}
		
		public function get hasWeapon () :Boolean {
			return Boolean(weaponContainer.numChildren)
		}
		
		public function clear () :void {
			weaponContainer.removeChildren();
		}
		
		public function stopGlowWeapon () :void {
			if (this.weapon) {
				weapon.stopGlow();
			}
		}
		
		public function set block (value:Boolean) :void {
			_blockFlag = value;
		}
		
		public function get block () :Boolean {
			return _blockFlag;
		}
		
	}

}