package com.sla.mvc.view.field.minion 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.FieldEvent;
	import com.sla.event.starling.StarlingFieldEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.asset.Stock;
	import com.sla.mvc.view.card.Card;
	import feathers.controls.Label;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Minion extends Sprite implements IMinion
	{
		
		public static const WIDTH:int = 60;
		public static const HEIGHT:int = 80;
		private static var _preview:Minion;
		private var cardData:CardData;
		
		private var attackLabel:TextField;
		private var healthLabel:TextField;
		
		private var _health:int;
		private var _healthBob:int;
		private var _defaultHealth:int;
		private var _maxHealth:int;
		private var _canAttack:Boolean = true;
		private var _block:Boolean = false;
		private var _enemy:Boolean = false;
		private var _copy:IMinion;
		private var _attack:int;
		private var _defaultAttack:int;
		private var _attackBob:int = 0;
		
		private var freezeSprite:Sprite;
		private var freezeQuad:Quad;
		private var freezeFlag:Boolean = false;
		
		private var provocationSprite:Sprite;
		private var provocationQuad:Quad;
		private var provocationFlag:Boolean = false;
		
		private var shieldSprite:Sprite;
		private var shieldQuad:Quad;
		private var shieldFlag:Boolean = false;
		
		private var spellUpSprite:Sprite;
		private var spellUpQuad:Quad;
		private var spellUpFlag:Boolean = false;
		
		private var shadowSprite:Sprite;
		private var shadowQuad:Quad;
		private var shadowFlag:Boolean = false;
		
		private var widgetSprite:Sprite;
		private var widget:MinionWidget;
		
		private var activeAptitudeFlag:Boolean = false;
		private var _activeManacost:int;
		
		private var _activeBlock:Boolean = false;
		
		private var flySprite:Sprite;
		private var flyQuad:Quad;
		private var flyFlag:Boolean = false;
		
		
		private var doubleAttackSprite:Sprite;
		private var doubleAttackQuad:Quad;
		private var doubleAttackFlag:Boolean = false;
		
		private var spellInvisibleSprite:Sprite;
		private var spellInvisibleQuad:Quad;
		private var spellInvisibleFlag:Boolean = false;
		
		private var dumbnessSprite:Sprite;
		private var dumbnessQuad:Quad;
		private var dumbnessFlag:Boolean = false;
		
		private var card:Card;
		
		private var showMirrorFlag:Boolean = false;
				
		public function Minion(cardData:CardData = null, color:uint = 0x999999) 
		{
			this.cardData = cardData;
			this.block = true;
			
			if (cardData) {
				card = new Card(cardData);
			}
			
			provocationSprite = new Sprite();
			provocationSprite.touchable = false;
			provocationSprite.x -= (WIDTH / 2 + 7);
			provocationSprite.y -= (HEIGHT / 2 + 7);
			addChild(provocationSprite);
			
			provocationQuad = new Quad(WIDTH + 14, HEIGHT + 14, 0x555555);
			provocationQuad.touchable = false;
			
			var bg:Sprite = new Sprite();
			var quad:Quad = new Quad(WIDTH, HEIGHT, color);
			bg.addChild(quad);
			
			if (cardData) {
				var cardAsset:Image = new Image(Stock.getMinionTextrure(cardData.id))
				bg.addChild(cardAsset);
			}
			
			bg.x -= WIDTH / 2;
			bg.y -= HEIGHT / 2;
			addChild(bg);
			
			dumbnessSprite = new Sprite();
			dumbnessSprite.touchable = false;
			bg.addChild(dumbnessSprite);
			
			dumbnessQuad = new Quad(WIDTH, HEIGHT, 0xDDA0DD);
			dumbnessQuad.alpha = 0.5;
			dumbnessQuad.touchable = false;
			
			
			spellUpSprite = new Sprite();
			spellUpSprite.touchable = false;
			bg.addChild(spellUpSprite);
			
			spellUpQuad = new Quad(WIDTH, HEIGHT, 0xB404AE);
			spellUpQuad.alpha = 0.2;
			spellUpQuad.touchable = false;
			
			spellInvisibleSprite = new Sprite();
			spellInvisibleSprite.touchable = false;
			bg.addChild(spellInvisibleSprite);
			
			spellInvisibleQuad = new Quad(WIDTH, HEIGHT, 0x58FAF4);
			spellInvisibleQuad.alpha = 0.3;
			
			doubleAttackSprite = new Sprite();
			doubleAttackSprite.touchable = false;
			doubleAttackSprite.x -= (WIDTH / 2);
			doubleAttackSprite.y -= (HEIGHT / 2);
			addChild(doubleAttackSprite);
			
			doubleAttackQuad = new Quad(WIDTH, HEIGHT, 0xFF);
			doubleAttackQuad.alpha = 0.5;
			doubleAttackQuad.touchable = false;
			
			flySprite = new Sprite();
			flySprite.touchable = false;
			flySprite.x -= (WIDTH / 2);
			flySprite.y -= (HEIGHT / 2);
			addChild(flySprite);
			
			flyQuad = new Quad(WIDTH, 5, 0xFFFFFF);
			flyQuad.y = HEIGHT * 0.6;
			flyQuad.touchable = false;
			
			shadowSprite = new Sprite();
			shadowSprite.touchable = false;
			bg.addChild(shadowSprite);
			
			shadowQuad = new Quad(WIDTH, HEIGHT, 0x222222);
			shadowQuad.alpha = 0.7;
			shadowQuad.touchable = false;
			
			widgetSprite = new Sprite;
			widgetSprite.touchable = false;
			widgetSprite.y = (HEIGHT / 2);
			addChild(widgetSprite);
			
			shieldSprite = new Sprite();
			shieldSprite.touchable = false;
			shieldSprite.x -= (WIDTH / 2 + 7);
			shieldSprite.y -= (HEIGHT / 2 + 7);
			addChild(shieldSprite);
			
			shieldQuad = new Quad(WIDTH + 14, HEIGHT + 14, 0xFFFF00);
			shieldQuad.alpha = 0.3;
			shieldQuad.touchable = false;
						
			freezeSprite = new Sprite();
			freezeSprite.touchable = false;
			freezeSprite.x -= WIDTH / 2;
			freezeSprite.y -= HEIGHT / 2;
			addChild(freezeSprite);
			
			freezeQuad = new Quad(WIDTH, HEIGHT, 0x56A5EC);
			freezeQuad.touchable = false;
			freezeQuad.alpha = 0.7;
			
					
			if (cardData) {
				this.name = cardData.title;
				
				var attackQuad:Quad = new Quad(15, 15, 0xFFFFFF);
				attackQuad.y = HEIGHT - 15;
				bg.addChild(attackQuad);
				
				var healthQuad:Quad = new Quad(15, 15, 0xFFFFFF);
				healthQuad.y = HEIGHT - 15;
				healthQuad.x = WIDTH - 15;
				bg.addChild(healthQuad);
					
				attackLabel = new TextField(15, 15, cardData.attack.toString(), 'Verdana', 12, 0x0, true);
				attackLabel.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
				attackLabel.hAlign = HAlign.CENTER;
				attackLabel.x = 1;
				attackLabel.y = HEIGHT - 17;
				bg.addChild(attackLabel);
				_attack = _defaultAttack = cardData.attack;
				
				healthLabel = new TextField(15,15, cardData.health.toString(), 'Verdana', 12, 0x0, true );
				healthLabel.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
				healthLabel.hAlign = HAlign.CENTER;
				healthLabel.x = WIDTH - 13;
				healthLabel.y = HEIGHT - 17;
				bg.addChild(healthLabel);
				_health = _defaultHealth = _maxHealth = cardData.health;
				
				if (cardData.widget) {
					widget = new MinionWidget(cardData.widget);
					widgetSprite.addChild(widget);
					widget.addEventListener(MinionWidget.ACTIVATE_COMPLETE, onWidgetAnimComplete);
				}
				
				if (cardData.hasActiveAptitude) {
					activeAptitudeFlag = true;
					_activeManacost = cardData.activeManacost;
				}
			}
		}
		
		public function attachWidget (type:int) :void {
			if (widget) {
				widget.removeEventListener(MinionWidget.ACTIVATE_COMPLETE, onWidgetAnimComplete);
				widgetSprite.removeChildren();
			}
			widget = new MinionWidget(type);
			widgetSprite.addChild(widget);
			widget.addEventListener(MinionWidget.ACTIVATE_COMPLETE, onWidgetAnimComplete);
		}
		
		public function set showMirror (value:Boolean) :void {
			showMirrorFlag = value;
		}
		public function get showMirror () :Boolean {
			return showMirrorFlag;
		}
		
		public function getCard () :Card {
			return card;
		}
 		
		public function get activeBlock () :Boolean {
			return _activeBlock;
		}
		public function set activeBlock (value:Boolean) :void {
			_activeBlock = value;
		}
		
		public function get hasActiveAptitude () :Boolean {
			return activeAptitudeFlag;
		}
		
		public function get activeManacost () :int {
			return _activeManacost;
		}
		
		public function activateWidget () :void {
			if (widget) {
				widget.activate();
			} else {
				dispatchEvent (new StarlingFieldEvent(StarlingFieldEvent.WIDGET_ACTIVATE));
			}
		}
		
		private function onWidgetAnimComplete () :void {
			dispatchEvent (new StarlingFieldEvent(StarlingFieldEvent.WIDGET_ACTIVATE));
		}
		
		public function set copy (value:IMinion) :void {
			this._copy = value;
		}
		public function get copy () :IMinion {
			return _copy;
		}
		
		public function get attackValue () :int {
			var value:int = 0;
			if (cardData) {
				value = cardData.attack;
			}
			return value;
		}
		
		public function clone () :IMinion {
			var minion:IMinion = new Minion(cardData);
			minion.block = true;
			minion.setMaxHealth(this.getMaxHealth());
			minion.setHealth(this.getHealth());
			minion.setAttackBob(this.getAttackBob());
			minion.setAttack(this._attack);
			if (this.isProvocation) {
				minion.activateProvocation();
			}
			if (this.hasShield) {
				minion.activateShield();
			}
			if (spellUpFlag) {
				minion.activateSpellUp();
			}
			if (freezeFlag) {
				minion.activateFreeze();
			}
			if (doubleAttackFlag) {
				minion.activateDoubleAttack();
			}
			if (inShadow) {
				minion.activateShadow();
			}
			if (canFly) {
				minion.activateFly();
			}
			if (isSpellInvisible) {
				minion.activateSpellInvisible();
			}
			if (dumbnessFlag) {
				minion.dumbness();
			}
			return minion;
		}
		
		public function set block (value:Boolean) :void {
			_block = value;
			this.useHandCursor = !_block;
		}
		public function get block () :Boolean {
			return _block;
		}
		
		public function asDO () :Sprite {
			return this as Sprite;
		}
		
		public static function get prewiew () :Minion {
			if (_preview == null) {
				_preview = new Minion(null, 0xFF0000);
			}
			return _preview;
		}
		
		public function set isEnemy (value:Boolean) :void {
			_enemy = value;
		}
		public function get isEnemy () :Boolean {
			return _enemy;
		}
		
		public function glow () :void {
			this.filter = Minion.glowFilter;
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
		public function dropShadow () :void {
			this.filter = Minion.shadowFilter;
		}
		public function stopDropShadow() :void {
			this.filter = null;
		}
		private static var _shadowWilter:BlurFilter; 
		private static function get shadowFilter () :BlurFilter {
			if (!_shadowWilter) {
				_shadowWilter = BlurFilter.createDropShadow(6,0.785,0x0,0.7,0.3,0.3);
			}
			return _shadowWilter;
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
			 if (value == _health) {
				return;
			}
			_health = value;
            var finalHealth:int = _health + _healthBob;
            if (_health > _defaultHealth) {
                if (_health < _maxHealth) {
					healthLabel.color = 0xFF0000;
				} else {
					healthLabel.color = 0x00FF00;
				}
				
            } else {
				if (_health < _maxHealth) {
					healthLabel.color = 0xFF0000;
				} else if (_health == _maxHealth) {
					healthLabel.color = 0x0;
				} else {
					healthLabel.color = 0xFF0000;
				}
			}
           
			if (finalHealth < 0) finalHealth = 0;
			if (_health > _maxHealth) {
				_maxHealth = _health;
			}
			healthLabel.text = "" + finalHealth;
		}
		public function getHealth () :int {
			return _health;
		}
		
		public function getDefaultHealth() :int {
			return 0;
		}
		
		public function setAttack (value:int) :void {
			_attack = value;
            var finalAttack:int = _attack + _attackBob;
            if (_attack > _defaultAttack) {
               attackLabel.color = 0x00FF00;
            } else {
               attackLabel.color = 0x0;
            }
			if (_attackBob > 0) {
				attackLabel.color = 0x00FF00;
			}
			attackLabel.text = finalAttack.toString();
		}
		public function getAttack () :int {
			return _attack;
		}
		
		public function setMaxHealth (value:int):void {
			_maxHealth = value;
		}
		public function getMaxHealth () :int {
			return _maxHealth;
		}
	
		public function getAttackBob () :int {
			return _attackBob;
		}
		public function setAttackBob (value:int) :void  {
			_attackBob = value;
		}
	
		public function treatment (value:int) :void {
			
		}
	
		public function activateShield() :void {
			shieldSprite.addChild(shieldQuad);
			shieldFlag = true;
		}
		public function destroyShield ():void {
			shieldSprite.removeChildren();
			shieldFlag = false;
		}
		public function get hasShield () :Boolean {
			return shieldFlag;
		}
	
		public function activateShadow() :void {
			shadowSprite.addChild(shadowQuad);
			shadowFlag = true;
		}
		public function destroyShadow() :void {
			shadowFlag = false;
			if (shadowSprite.contains(shadowQuad)) {
				shadowSprite.removeChild(shadowQuad);
			}
		}
		public function get inShadow () :Boolean {
			return shadowFlag;
		}
	
		public function activateDoubleAttack()  :void {
			doubleAttackFlag = true;
			doubleAttackSprite.addChild(doubleAttackQuad);
		}
		public function deactivateDoubleAttack() :void {
			doubleAttackFlag = false;
			if (doubleAttackSprite.contains(doubleAttackQuad)) {
				doubleAttackSprite.removeChild(doubleAttackQuad);
			}
		}
	
		public function dumbness () :void {
			dumbnessFlag = true;
			dumbnessSprite.addChild(dumbnessQuad);
			deactivateFreeze();
			deactivateProvocation();
			deactivateSpellInvisible();
			deactivateSpellUp();
			destroyShield();
			destroyShadow();
			deactivateDoubleAttack();
			widgetSprite.removeChildren();
		}
	
		public function set canAttack (value:Boolean) :void {
			_canAttack = value;
		}
		public function get canAttack () :Boolean {
			return _canAttack;
		}
	
		public function activateProvocation () :void {
			provocationSprite.addChild(provocationQuad);
			provocationFlag = true;
		}
		public function deactivateProvocation () :void {
			provocationSprite.removeChildren();
			provocationFlag = false;
		}
		public function get isProvocation () :Boolean {
			return provocationFlag;
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
			spellInvisibleSprite.addChild(spellInvisibleQuad);
			spellInvisibleFlag = true;
		}
		public function  deactivateSpellInvisible () :void {
			spellInvisibleSprite.removeChildren();
			spellInvisibleFlag = false;
		}
		
		public function get isSpellInvisible () :Boolean {
			return spellInvisibleFlag;
		}
		
		public function activateSpellUp () :void {
			spellUpSprite.addChild(spellUpQuad);
			spellUpFlag = true;
		}
		public function deactivateSpellUp() :void {
			spellUpSprite.removeChildren();
			spellUpFlag = false;
		}
		
		public function activateFly () :void {
			flySprite.addChild(flyQuad);
			flyFlag = true;
		}
		public function deactivateFly () :void {
			flySprite.removeChildren();
			flyFlag = false
		}
		public function get canFly () :Boolean {
			return flyFlag;
		}
		
		
		
	}

}