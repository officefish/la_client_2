package com.sla.mvc.view.field {
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.easing.ExpoInOut;
	import com.greensock.easing.Power0;
	import com.greensock.plugins.Positions2DPlugin;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.sla.event.starling.StarlingFieldEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.field.minion.Minion;
	import feathers.controls.Button;
	import flash.geom.Point;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import com.sla.mvc.view.field.mana.ManaWidget;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Field extends Sprite 
	{
		
		private var _initFlag:Boolean = false;
		private var arena:Sprite;
		private var arenaAsset:Quad;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var arenaWidth:int;
		private var arenaHeight:int;
		
		private var arenaXpos:int;
		private var arenaYpos:int;
		
		private var background:Quad;
		
		private var playerRow:Sprite;
		private var opponentRow:Sprite;
		
		private var playerManaWidget:ManaWidget;
		private var opponentManaWidget:ManaWidget;
		
		public static const PADDING:int = 30;
		
		private var cursorPoint:Point = new Point();
		private var cursorLocalX:int;
		private var currentPositions:Array;	
		private var minionPreviewIndex:int = -1;
		private var tempMinionPreviewIndex:int = -1;
		
		private var sortTimeline:TimelineMax;
		private var dragMode:Boolean = false;
		
		private var minionPositions:Vector.<int>;
		
		private var endStepButton:Button;
		
		private var scaleSprite:Sprite;
		
		public function Field() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event) :void {
			if (!_initFlag) {
				init();
			}
		}
		
		public function resize(stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			this.arenaWidth = Math.round(stageWidth * 0.8);
			this.arenaHeight = stageHeight - 150;
			this.arenaXpos =  Math.round(stageWidth * 0.1);
			this.arenaYpos = 60;
		}
		
		private function init () :void {
			
			background = new Quad(stageWidth, stageHeight, 0x111f3b);
			addChild(background);
			
			scaleSprite = new Sprite();
			addChild(scaleSprite);
			
			scaleSprite.x = stageWidth / 2;
			scaleSprite.y = stageHeight / 2;
			
			arena = new Sprite();
			scaleSprite.addChild(arena);
			
			playerRow = new Sprite();
			opponentRow = new Sprite();
			
			arenaAsset = new Quad(arenaWidth, arenaHeight, 0xEEEEEE);
			arena.addChild(arenaAsset);
			
			arena.x = arenaXpos - stageWidth /2;
			arena.y = arenaYpos - stageHeight / 2;
			
			opponentRow.y = 170;
			playerRow.y = arenaHeight - 170;
			
			playerRow.x = opponentRow.x = arenaWidth/2;
			
			arena.addChild(playerRow);
			arena.addChild(opponentRow);
			
			sort(playerRow, true);
			
			endStepButton = new Button();
			
			endStepButton.label = 'End Step';
			endStepButton.styleNameList.add('endStepButton');	
			endStepButton.useHandCursor = true;
			arena.addChild(endStepButton);
			endStepButton.x = arenaWidth - 100;
			endStepButton.y = (arenaHeight - 40) / 2;
			
			playerManaWidget = new ManaWidget();
			playerManaWidget.y = arenaHeight;
			playerManaWidget.x = arenaWidth - playerManaWidget.width; 
			arena.addChild(playerManaWidget);
			
			opponentManaWidget = new ManaWidget();
			opponentManaWidget.x = playerManaWidget.x;
			opponentManaWidget.y = - opponentManaWidget.height;
			arena.addChild(opponentManaWidget);
			
			playerManaWidget.setMana(0, 0);
			opponentManaWidget.setMana(0, 0);
			
			_initFlag = true;
		}
		
		public function shake (value:int) :void {
			//if (value < 3) {
			//	return;
			//}
			if (value > 10) {
				value = 10;
			}
			var scaleIndex:Number = 1 - (0.0015 * value);
			var timeline:TimelineMax = new TimelineMax();
			var xPos:int = scaleSprite.x;
			var yPos:int = scaleSprite.y;
			var scaleXPos:int = xPos;
			var scaleYPos:int = yPos;
			timeline.add('sprin');
			timeline.to (scaleSprite, .1, { x:scaleXPos, y:scaleYPos, scaleX:scaleIndex, scaleY:scaleIndex, ease:Elastic.easeOut }, 'spin' );
			timeline.to (scaleSprite, 0.1, { x:xPos, y:yPos, delay:0.1, scaleX:1, scaleY:1, ease:Elastic.easeOut }, 'spin' );
		}
		
		public function setPlayerMana (price:int, overload:int) :void {
			playerManaWidget.setMana(price, overload);
		}
		
		public function setOpponentMana (price:int, overload:int) :void {
			opponentManaWidget.setMana(price, overload);
		}
		
		public function clearPlayerMana () :void {
			playerManaWidget.setMana(0, 0);
		}
		
		public function clearOpponentMana () :void {
			//opponentManaWidget.setMana(0, 0);
		}
		
		public function enableStepButton () :void {
			endStepButton.addEventListener ( Event.TRIGGERED, onEndStep);
			endStepButton.filter = Field.glowFilter;
			
		}
		
		public function disableStepButton () :void {
			endStepButton.removeEventListener ( Event.TRIGGERED, onEndStep);
			endStepButton.filter = null;
			
		}
		
		private function onEndStep () :void {
			dispatchEvent(new StarlingFieldEvent(StarlingFieldEvent.END_STEP));
		}
		
		private static var _glowWilter:BlurFilter; 
		private static function get glowFilter () :BlurFilter {
			if (!_glowWilter) {
				_glowWilter = BlurFilter.createGlow(0x00FFFF, 1, 3, .5);
				_glowWilter
			}
			return _glowWilter;
		}
		
		public function addHeroes (playerHero:IHero, opponentHero:IHero) :void {
			var playerHeroDO:DisplayObject = playerHero.asDO();
			var opponentHeroDO:DisplayObject = opponentHero.asDO();
			
			playerHeroDO.x = arenaWidth / 2;
			playerHeroDO.y = arenaHeight - playerHeroDO.height/2;
			arena.addChild(playerHeroDO);
			
			opponentHeroDO.x = playerHeroDO.x;
			opponentHeroDO.y = opponentHeroDO.height / 2;
			arena.addChild(opponentHeroDO);
		}
		
		public function findPosition () :void {
			minionPreviewIndex = -1;
			if (!playerRow.numChildren) return;
			if (playerRow.numChildren >= 7) return;
			dragMode = true;
			currentPositions = MinionPosition.getArrayPositions(playerRow.numChildren + 1);
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler);
		}
		
		public function stopFindPosition (sortFlag:Boolean) :void {
			dragMode = false;
			Starling.current.stage.removeEventListener(TouchEvent.TOUCH, stage_touchHandler);
			if (playerRow.contains(Minion.prewiew)) {
				playerRow.removeChild(Minion.prewiew);
			}
			if (sortFlag) {
				sort(playerRow);
			}
		}
		
		private function stage_touchHandler(event:TouchEvent):void
		{
			if (!dragMode) {
				return;
			}
						
			var touch:Touch = event.getTouch(Starling.current.stage, null, -1);
			
			if(!touch) 
			{
				return;
			}
			if (playerRow.numChildren >= 7) {
				return;
			}
			if(touch.phase == TouchPhase.MOVED)
			{
				//MonsterDebugger.log('stage_touchHandler_moved');
				//MonsterDebugger.log('dragMode:' + dragMode);
				
				touch.getLocation(Starling.current.stage, cursorPoint);
				cursorLocalX = cursorPoint.x - (arena.x + stageWidth /2 + arenaWidth / 2) - Minion.WIDTH/2;
				
				tempMinionPreviewIndex = findNearNumberIndex(currentPositions, cursorLocalX);
				if (minionPreviewIndex != tempMinionPreviewIndex) {
					minionPreviewIndex = tempMinionPreviewIndex;
					playerRow.addChildAt(Minion.prewiew, minionPreviewIndex);
					sort(playerRow);
				}
						
			}
		}
		
		private function findNearNumberIndex( arr:Array, targetNumber:Number ):int
		{
			// проверяем входящие аргументы
			if( !arr || isNaN( targetNumber ) )
				return -1;

			// currDelta - текущая разница
			var currDelta:Number;

			// nearDelta - наименьшая разница
			var nearDelta:Number;

			// nearIndex - индекс наименьшей разницы. Задаем изначально равным -1.
			// если массив с нулевой длиной - возвратится эта самая -1
			var nearIndex:Number = -1;

			// счетчик
			var i:Number = arr.length;

			// начинаем крутить цикл с конца массива.
			// с конца - чтобы не заводить доп. переменную
			while( i-- )
			{
				// берем по модулю раницу между заданным числом и текущим по индексу массива
				currDelta = Math.abs( targetNumber - arr[i] );

				// если nearIndex меньше нуля
				// (т.е мы в первый раз должны занести currDelta, чтобы было с чем сравнивать последующие итерации)
				// или currDelta меньше nearDelta
				if( nearIndex < 0 || currDelta < nearDelta )
				{
					// задаем индекс (наименьшей разницы) как текущий индекс
					nearIndex = i;
					// задаем наименьшую разницу как текущую
					nearDelta = currDelta;
				}
			}

			// возвращаем индекс наименьшей разницы
			return nearIndex;
		}
		
		public function sort (row:Sprite, quick:Boolean = false, uniqueTimelineFlag:Boolean = false) :void {
			minionPositions = MinionPosition.getVectorPositions(row.numChildren);
			var minion:Sprite;
			var i:int;
			if (quick) {
				for (i = 0; i < minionPositions.length; i ++) 
				{
					minion = row.getChildAt(i) as Sprite;
					minion.x = minionPositions[i];
				}
			} else {
				if (uniqueTimelineFlag) {
					var uniqueTimeline:TimelineMax = new TimelineMax();
					uniqueTimeline.pause();
					uniqueTimeline.add('spin');
					for (i = 0; i < minionPositions.length; i ++) {
						minion = row.getChildAt(i) as Sprite;
						uniqueTimeline.to(minion, 0.5, { x:minionPositions[i], ease:Expo.easeOut }, 'spin' );
					}
					uniqueTimeline.play();
				} else {
					if (sortTimeline) {
						sortTimeline.kill();
					}
					sortTimeline = new TimelineMax();
					sortTimeline.pause();
					sortTimeline.add('spin');
					for (i = 0; i < minionPositions.length; i ++) {
						minion = row.getChildAt(i) as Sprite;
						sortTimeline.to(minion, 0.5, { x:minionPositions[i], ease:Expo.easeOut }, 'spin' );
					}
					sortTimeline.play();
				}
				
				
			}
			
		}
		
		public function getMinionPreviewIndex () :int {
			var index:int = minionPreviewIndex;
			if (index < 0) index = 0;
			return index;
		}
		
		public function addMinion(cardData:CardData, position:int, client:Boolean) :Minion {
			var minion:Minion = new Minion(cardData);
			minion.canAttack = false;
			if (client) {
				if (playerRow.contains(Minion.prewiew)) {
					playerRow.removeChild(Minion.prewiew);
				}
				try {
					playerRow.addChildAt(minion, position);
				} catch (e:Error) {
					MonsterDebugger.log ('Warning! Invalid minion index for player row!')
					playerRow.addChild(minion);
				}
				sort(playerRow);
			} else {
				try {
					opponentRow.addChildAt(minion, position);
				} catch (e:Error) {
					MonsterDebugger.log ('Warning! Invalid minion index for opponent row!')
					opponentRow.addChild(minion);
				}
				minion.isEnemy = true;
				sort(opponentRow);
			}
			return minion;
		}
		
		public function removeMinion (minion:IMinion) :void {
			var row:Sprite;
			if (playerRow.contains(minion.asDO())) {
				row = playerRow;
			} else if (opponentRow.contains(minion.asDO())) {
				row = opponentRow;
			}
			if (row) {
				row.removeChild(minion.asDO());
				sort(row, false, true);
			}
			
		}
		
		public function getMinionPosition(index:int) :int {
			return minionPositions[index];
		}
		
		public function get numMinions () :int {
			return playerRow.numChildren;
		}
		
		public function getMinion (index:int, player:Boolean = true) :IMinion {
			var minion:IMinion;
			if (player) {
				minion = playerRow.getChildAt(index) as IMinion;
			} else {
				minion = opponentRow.getChildAt(index) as IMinion;
			}
			return minion;
		}
		
		public function glowMinions () :void {
			for (var i:int = 0; i < playerRow.numChildren; i ++) {
				var minion:IMinion = (playerRow.getChildAt (i) as IMinion);
				if (minion.canAttack) {
					minion.block = false;
					minion.glow();
				}
			}
		}
		public function getPlayerMinions () :Vector.<IMinion> {
			var vector:Vector.<IMinion> = new Vector.<IMinion>();
			for (var i:int = 0; i < playerRow.numChildren; i++ ) {
				vector.push(playerRow.getChildAt(i) as IMinion)
			}
			return vector;
		}
		
		public function getOpponentMinions () :Vector.<IMinion> {
			var vector:Vector.<IMinion> = new Vector.<IMinion>();
			for (var i:int = 0; i < opponentRow.numChildren; i++ ) {
				vector.push(opponentRow.getChildAt(i) as IMinion)
			}
			return vector;
		}
		public function getOpponentProvocation () :Vector.<IMinion> {
			var vector:Vector.<IMinion> = new Vector.<IMinion>();
			var minion:IMinion;
			for (var i:int = 0; i < opponentRow.numChildren; i++ ) {
				minion = opponentRow.getChildAt(i) as IMinion;
				if (minion.isProvocation)
				vector.push(minion)
			}
			return vector;
		}
		
		public function blockMinions () :void {
			var minion:IMinion;
			for (var i:int = 0; i < playerRow.numChildren; i ++) {
				minion = playerRow.getChildAt (i) as IMinion;
				minion.canAttack = false;
				minion.stopGlow();
				minion.block = true;
			}
		}
		public function unblockActive () :void {
			var minion:IMinion;
			for (var i:int = 0; i < playerRow.numChildren; i ++) {
				minion = playerRow.getChildAt (i) as IMinion;
				minion.activeBlock = false;
			}
		}
		public function stopGlowMinionsExceptMinion (minion:IMinion) :void {
			var otherMinion:IMinion;
			for (var i:int = 0; i < playerRow.numChildren; i ++) {
				otherMinion = playerRow.getChildAt (i) as IMinion;
				if (otherMinion == minion) continue;
				otherMinion.stopGlow();
			}
		}
		public function markMinionsAsAttackAvailable(list:Array):void {
			var minion:IMinion;
			for (var i:int = 0; i < list.length; i ++) {
				minion = playerRow.getChildAt (list[i]) as IMinion;
				minion.canAttack = true;
				minion.block = false;
			}
		}
		
	}

}