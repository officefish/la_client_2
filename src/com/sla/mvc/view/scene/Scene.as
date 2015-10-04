package com.sla.mvc.view.scene 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Bounce;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Power0;
	import com.greensock.easing.Power1;
	import com.greensock.motionPaths.CirclePath2D;
	import com.greensock.motionPaths.Direction;
	import com.greensock.plugins.CirclePath2DPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.sla.mvc.view.field.minion.hero.Hero;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.field.minion.IMinion;
	import flash.display.BitmapData;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;

	import com.sla.event.starling.StarlingSceneEvent;
	import flash.geom.Point;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Scene extends Sprite 
	{
		
		private var _playerHero:DisplayObject;
		private var _opponentHero:DisplayObject;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var animationCof:int;
		
		private var heroesLevel:Sprite;
		private var backgroundLevel:Sprite;
		
		private var darkenSprite:Sprite;
		
		private var animationLevel:Sprite;
		
		private var damageLevel:Sprite;
		private var attackPosition:Point;
		private var attackLine:Image;
		private var attackShape:flash.display.Sprite = new flash.display.Sprite();
		private var cursorPoint:Point = new Point();
		private var attackBmd:BitmapData;
		private var attackTexture:Texture;
		private var attackTouch:Touch;
		private var attackTargetTouch:Touch;
		private var onTargetInit:Function;
		
		private var warningLabel:TextField;
		
		public function Scene() 
		{
			super();
			
			backgroundLevel = new Sprite;
			addChild(backgroundLevel);
			
			heroesLevel = new Sprite();
			addChild(heroesLevel);
			
			animationLevel = new Sprite();
			addChild(animationLevel);
			
			damageLevel = new Sprite();
			addChild(damageLevel);
			
			darkenSprite = new Sprite();
			
			
		}
		
		public function warning (value:String) :void {
			warningLabel.alpha = 1;
			warningLabel.text = value;
			animationLevel.addChild(warningLabel);
			TweenLite.to (warningLabel, 2, { delay:1.5, alpha:0, ease:Power0.easeNone, onComplete:onWarningComplete } );
		}
		
		private function onWarningComplete () :void {
			animationLevel.removeChild(warningLabel);
		}
		public function startDraw (position:Point, onTargetInit:Function) :void {
			this.onTargetInit = onTargetInit;
			attackPosition = position; 
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler);
		}
		
		private function stage_touchHandler(event:TouchEvent):void {
			
			var touch:Touch = event.getTouch(Starling.current.stage, null, -1); 
			touch.getLocation(Starling.current.stage, cursorPoint);
			
			animationLevel.removeChildren();
			animationLevel.touchable = false;
			
			attackShape.graphics.clear();
			attackShape.graphics.lineStyle(2, 0xFF0000, 1);
			attackShape.graphics.moveTo(attackPosition.x, attackPosition.y);
			attackShape.graphics.lineTo(cursorPoint.x, cursorPoint.y);
			attackBmd = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00FFFFFF);
			attackBmd.draw(attackShape);
			if (attackTexture) {
				attackTexture.dispose();
			}
			attackTexture = Texture.fromBitmapData(attackBmd);
			attackLine = new Image(attackTexture);
			animationLevel.addChild(attackLine);
			
			if (touch.phase == TouchPhase.ENDED) 
			{
				//MonsterDebugger.log(event.target);
				var target:IMinion; 
				var targetInit:Boolean = false;
				if (event.target is IMinion) {
					target = event.target as IMinion;
					targetInit = true;
				}
				if ((event.target as DisplayObject).parent &&
					(event.target as DisplayObject).parent is IMinion && !targetInit) {
					target = (event.target as DisplayObject).parent as IMinion;
					targetInit = true;
				}
				if ((event.target as DisplayObject).parent &&
					(event.target as DisplayObject).parent.parent &&
					(event.target as DisplayObject).parent.parent is IMinion && !targetInit) {
					target = (event.target as DisplayObject).parent.parent as IMinion;
					targetInit = true;
				}
				if ((event.target as DisplayObject).parent &&
					(event.target as DisplayObject).parent.parent &&
					(event.target as DisplayObject).parent.parent.parent &&
					(event.target as DisplayObject).parent.parent.parent is IMinion && !targetInit) {
					target = (event.target as DisplayObject).parent.parent.parent as IMinion;
					targetInit = true;
				}
				
				stopDraw(target);
			}
			
			
		}
		
		private function stopDraw (minion:IMinion) :void {
			Starling.current.stage.removeEventListener(TouchEvent.TOUCH, stage_touchHandler);
			animationLevel.removeChildren();
			onTargetInit(minion);
		}
		
		public function addDamage (damage:DisplayObject) :void {
			damageLevel.addChild(damage);
		}
		
		public function addMinion (minion:Sprite) :void {
			heroesLevel.addChild(minion);
		}
		
		public function getAnimationLevel () :DisplayObjectContainer {
			return animationLevel;
		}
		
		public function removeAllMinions () :void {
			heroesLevel.removeChildren();
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			darkenSprite.removeChildren();
			var bg:Quad = new Quad(stageWidth, stageHeight, 0x222222);
			bg.alpha = 0.7;
			darkenSprite.addChild(bg);
			
			warningLabel = new TextField(stageWidth, 40, '', 'Verdana', 12, 0x0, true);
			warningLabel.hAlign = HAlign.CENTER;
			warningLabel.y = stageHeight / 2 - 35;
		}
		
		public function set playerHero (value:DisplayObject) :void {
			this._playerHero = value;
		}
		public function set opponentHero (value:DisplayObject) :void {
			this._opponentHero = value;
		}
		
		public function welcomeAnimation () :Object {
					
			_playerHero.x = stageWidth/2 - stageWidth/4;
			_playerHero.y = stageHeight/2;

			_opponentHero.x = stageWidth/2 + stageWidth/4;
			_opponentHero.y = stageHeight/2;
			
			heroesLevel.addChild(_playerHero);
			heroesLevel.addChild(_opponentHero);
			
			var playerPosition:Point = new Point();
			playerPosition.x = (stageWidth) / 2;
			playerPosition.y = 60 + stageHeight - 150 - _playerHero.height/2;
			
			var middle1PlayerPosition:Point = new Point();
			middle1PlayerPosition.x = _playerHero.x + (playerPosition.x - _playerHero.x) * 0.7;
			middle1PlayerPosition.y = _playerHero.y + (playerPosition.y - _playerHero.y) * 0.3;
			
			var middle2PlayerPosition:Point = new Point();
			middle2PlayerPosition.x = _playerHero.x + (playerPosition.x - _playerHero.x) * 0.9;
			middle2PlayerPosition.y = _playerHero.y + (playerPosition.y - _playerHero.y) * 0.7;
			
			var player1Bezier:Array = [
				{x:middle1PlayerPosition.x, y:middle1PlayerPosition.y },
				{x:middle2PlayerPosition.x, y:middle2PlayerPosition.y },
				{x:playerPosition.x, y:playerPosition.y },
			]
			
			var opponentPosition:Point = new Point();
			opponentPosition.x = stageWidth / 2;
			opponentPosition.y = 60 + _opponentHero.height / 2;
			
			var middle1OpponentPosition:Point = new Point();
			middle1OpponentPosition.x = opponentPosition.x + (_opponentHero.x - opponentPosition.x) * 0.3;
			middle1OpponentPosition.y = opponentPosition.y + (_opponentHero.y - opponentPosition.y) * 0.7;
			
			var middle2OpponentPosition:Point = new Point();
			middle2OpponentPosition.x = opponentPosition.x + (_opponentHero.x - opponentPosition.x) * 0.1;
			middle2OpponentPosition.y = opponentPosition.y + (_opponentHero.y - opponentPosition.y) * 0.3;
		
			
			var player2Bezier:Array = [
				{x:middle1OpponentPosition.x, y:middle1OpponentPosition.y },
				{x:middle2OpponentPosition.x, y:middle2OpponentPosition.y },
				{x:opponentPosition.x, y:opponentPosition.y },
			]

			animationCof = 2;
		
			TweenMax.to(_playerHero, 1.0, {delay:1.5, bezier:player1Bezier, ease:Expo.easeOut, onComplete:onWelcomeComplete});
			TweenMax.to (_opponentHero, 1.0, {delay:1.5, bezier:player2Bezier, ease:Expo.easeOut, onComplete:onWelcomeComplete});
    
			
			return { };
		}
		
		private function onWelcomeComplete() :void {
			animationCof --;
			if (!animationCof) {
				dispatchEvent(new StarlingSceneEvent (StarlingSceneEvent.WELCOME_COMPLETE));
			}
		}
		
		public function darken() :void {
			darkenSprite.alpha = 1;
			backgroundLevel.addChild(darkenSprite);
		}
		
		public function getDarkenSprite () :Sprite {
			return darkenSprite;
		}
		
		public function removeDarken() :void {
			if (backgroundLevel.contains(darkenSprite)) {
				backgroundLevel.removeChild(darkenSprite);
			}
		}
		
		private static var _darkFilter:ColorMatrixFilter;
		private static function get darkFilter () :ColorMatrixFilter {
			if (!_darkFilter) {
				_darkFilter = new ColorMatrixFilter();
				_darkFilter.adjustBrightness(-0.30);
			}
			return _darkFilter;
		}
		
		public function darkenHeroes () :void {
			for (var i:int = 0; i < heroesLevel.numChildren; i ++) {
				var hero:Hero = heroesLevel.getChildAt(i) as Hero;
				if (hero) {
					hero.darken();
				}
			}
		}
		
		public function stopDarkenHeroes () :void {
			(_playerHero as IHero).stopDarken();
			(_opponentHero as IHero).stopDarken();
		}
	}

}