package com.sla.mvc.view.field.minion.hero 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.theme.Assets;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Hero extends Sprite implements IHero 
	{
		
		private var _enemyFlag:Boolean = false;
		private var type:int;
		
		private var healthLabel:TextField;
		private var healthBG:Quad;
		
		private var _health:int;
		private var _defaultHealth:int;
		private var _block:Boolean = true;
		private var _copy:IMinion;
		
		private var freezeSprite:Sprite;
		private var freezeQuad:Quad;
		private var freezeFlag:Boolean = false;
		
		private var bgSprite:Sprite;
		
		
		public function Hero() 
		{
			healthLabel = new TextField(30, 30, '', 'Verdana', 13, 0x0, true);
			healthBG = new Quad(20, 20, 0xFFFFFF);
			
			bgSprite = new Sprite();
			bgSprite.x -= 96/2;
			bgSprite.y -= 96/2;
			addChild(bgSprite);
			
			freezeSprite = new Sprite();
			freezeSprite.touchable = false;
			freezeSprite.x -= 96/2;
			freezeSprite.y -= 96 / 2;
			addChild(freezeSprite);
					
			freezeQuad = new Quad(96, 96, 0x56A5EC);
			freezeQuad.touchable = false;
			freezeQuad.alpha = 0.7;
		}
		
		
		
		public function set copy (value:IMinion) :void {
			this._copy = value;
		}
		public function get copy () :IMinion {
			return _copy;
		}
		
		public function set block (value:Boolean) :void {
			_block = value;
			if (value) {
				this.useHandCursor = false;
			} else {
				this.useHandCursor = true;
			}
		}
		public function get block () :Boolean {
			return _block;
		}
		
		public function showHealth () :void {
			bgSprite.addChild(healthBG);
			bgSprite.addChild(healthLabel);
		}
		
		public function asDO () :Sprite {
			return this as Sprite;
		}
		
		public function darken () :void {
			this.filter = darkFilter;
		}
		
		public function stopDarken() :void {
			this.filter = null;
		}
		
		private static var _darkFilter:ColorMatrixFilter; 
		private static function get darkFilter () :ColorMatrixFilter {
			if (!_darkFilter) {
				_darkFilter = new ColorMatrixFilter();
				_darkFilter.adjustBrightness(-0.30);
			}
			return _darkFilter;
		}
		
		// special hero functions
		public function hideHealth () :void {
			
		}
		public function setStartHealth(value:int) :void {
			_health = _defaultHealth = value;
			healthLabel.text = value.toString();
		}
		
		public function setType(value:int):void {
			this.type = value;
			var texture:Texture = Assets.getHeroAssetById(value); 
			var asset:Image = new Image(texture);
			asset.scaleX = 0.8;
			asset.scaleY = 0.8;
			bgSprite.addChild(asset); 
			healthBG.x = healthLabel.x = this.width - 20;
			healthBG.y = healthLabel.y = this.height - 20;
			healthLabel.y -= 5;
			healthLabel.x -= 5;
		}
		
		
		public function clone () :IMinion {
			var hero:Hero = new Hero();
			hero.setStartHealth(_defaultHealth);
			hero.setType(type);
			hero.setHealth(_health);
			hero.showHealth();
			if (freezeFlag) {
				hero.activateFreeze();
			}
			return hero;
		}
		public function clear():void {
			bgSprite.removeChildren();
			freezeSprite.removeChildren();
			freezeFlag = false;
		}
		public function get hasActiveAptitude () :Boolean {
			return false;
		}
		
		public function get activeManacost () :int {
			return 0;
		}
		
		public function getCard () :Card {
			return null;
		}
		public function set showMirror (value:Boolean) :void {
			
		}
		public function get showMirror () :Boolean {
			return false;
		}
		
		
		// minion functions
		
		public function set isEnemy (value:Boolean) :void {
			_enemyFlag = value;
		}
		public function get isEnemy () :Boolean {
			return _enemyFlag;
		}
		
		public function glow () :void {
			this.filter = Hero.glowFilter;
		}
		
		public function stopGlow () :void {
			this.filter = null;
		}
		private static var _glowWilter:BlurFilter; 
		private static function get glowFilter () :BlurFilter {
			if (!_glowWilter) {
				_glowWilter = BlurFilter.createGlow(0x00FFFF, 1, 3, .5);
				_glowWilter
			}
			return _glowWilter; 
		}
		
		public function getPosition () :Point {
			return new Point(this.x, this.y);
		}
		
		public function get globalPosition () :Point {
			var position:Point = getPosition();
			if (this.parent) {
				position = this.parent.localToGlobal(position);
			}
			return position;
		}
	
		public function setHealth (value:int) :void {
			_health = value;
			if (_health < _defaultHealth) {
				healthLabel.color = 0xFF0000;
			} else {
				healthLabel.color = 0x0;
			}
			healthLabel.text = _health.toString();
		}
		public function getHealth () :int {
			return 0;
		}
		
		public function getDefaultHealth() :int {
			return 0;
		}
		
		public function setAttack (value:int) :void {
			
		}
		public function getAttack () :int {
			return 0;
		}
		
		public function setMaxHealth (value:int):void {
			
		}
		public function getMaxHealth () :int {
			return 0;
		}
	
		public function getAttackBob () :int {
			return 0;
		}
		public function setAttackBob (value:int) :void {
			
		}
	
		public function treatment (value:int) :void {
			
		}
	
		public function activateShield() :void {
			
		}
		public function destroyShield ():void {
			
		}
	
		public function activateShadow() :void {
			
		}
		public function destroyShadow() :void {
			
		}
	
		public function activateDoubleAttack()  :void {
			
		}
		public function deactivateDoubleAttack() :void {
			
		}
	
		public function dumbness () :void {
			
		}
	
		public function set canAttack (value:Boolean) :void {
			
		}
		public function get canAttack () :Boolean {
			return false;
		}
	
		public function activateProvocation () :void {
			
		}
		public function deactivateProvocation () :void {
			
		}
		public function get isProvocation () :Boolean {
			return false;
		}
	
		public function activateFreeze () :void {
			freezeSprite.addChild(freezeQuad);
			freezeFlag = true;
		}
		public function deactivateFreeze() :void {
			if (freezeSprite.contains(freezeQuad)) {
				freezeSprite.removeChild(freezeQuad);
			}
			freezeFlag = false;
		}
	
		public function activateSpellInvisible () :void {
			
		}
		public function  deactivateSpellInvisible () :void {
			
		}
		public function get isSpellInvisible () :Boolean {
			return false;
		}
		
		public function activateSpellUp () :void {
			
		}
		public function deactivateSpellUp() :void {
			
		}
		
		public function get attackValue () :int {
			return 0;
		}
		
		public function dropShadow () :void {
			
		}
		public function stopDropShadow() :void {
			
		}
		public function get hasShield () :Boolean {
			return false;
		}
		
		public function activateWidget () :void {
			
		}
		public function get activeBlock () :Boolean {
			return false;
		}
		public function set activeBlock (value:Boolean) :void {
			
		}
		public function get inShadow () :Boolean {
			return false;
		}
		public function activateFly () :void {
			
		}
		public function deactivateFly () :void {
			
		}
		public function get canFly () :Boolean {
			return false;
		}
		public function attachWidget (type:int) :void {
			
		}
	
		
		
		
	}

}