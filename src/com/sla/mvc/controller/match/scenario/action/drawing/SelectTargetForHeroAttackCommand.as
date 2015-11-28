package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.Hero;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectTargetForHeroAttackCommand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var scene:Scene;
		
		[Inject]
		public var field:Field;
		
		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		[Inject]
		public var hand:PlayerHand; 
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		private var serviceData:Dictionary;
		
		private var hero:Hero;
		
		private var weaponIndex:int = 0;
		
		override public function execute():void 
		{
			MonsterDebugger.log('SelectTagetForHeroAttackCommand::execute()');
			
			weaponIndex = event.data.weaponIndex;
			
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
			
			hero = event.data.hero;
			hero.block = true;
			hero.stopGlow();
			hero.dropShadow();
			
			field.stopGlowMinions();
			hero.stopGlow();
			
			hero.scaleX = 1.1;
			hero.scaleY = 1.1;
			
			var enemyMinions:Vector.<IMinion> = new Vector.<IMinion>();
			var provocationFlag:Boolean = false;
			enemyMinions = field.getOpponentProvocation();
			if (enemyMinions.length) {
				provocationFlag = true;
			} else {
				enemyMinions = field.getOpponentMinions();
			}
					
			serviceData = new Dictionary(); 
			scene.darken();
			
			var index:int;
			var minion:IMinion;
			var copy:IMinion;
			for (var i:int = 0; i < enemyMinions.length; i++) {
				minion = enemyMinions[i];
				index = minion.asDO().parent.getChildIndex(minion.asDO());
				copy = copyMinion(minion);
				serviceData[copy] = {'index':index, 'player':false}
			}
			
			if (!provocationFlag) {
				minion = opponentHero;
				copy = copyMinion(minion);
				serviceData[copy] = { 'index': -1, 'player':false }
			}
			
			contextView.stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler);
			
		}	
		
		private function copyMinion (minion:IMinion) :IMinion {
			var copy:IMinion;
			var copyDO:Sprite; 
			var position:Point;
			copy = minion.clone();
			copyDO = copy.asDO();
			position = minion.getPosition();
			position = minion.asDO().parent.localToGlobal (position);
			copyDO.x = position.x;
			copyDO.y = position.y;
			scene.addMinion (copyDO);
			copy.glow();
			copyDO.useHandCursor = true;
			return copy;
		}
		
		private function stage_touchHandler(event:TouchEvent):void
		{
			
			var touch:Touch = event.getTouch(contextView.stage, null, -1);
			if(!touch) 
			{
				return; 
			}
			if(touch.phase == TouchPhase.BEGAN)
			{
				
				//MonsterDebugger.log(event.target);
				//(event.target as DisplayObject).filter = glowFilter;
				
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
				if (target)
				{
					if (target == hero) {
						return;
					}
					
					choiceComplete();
					
					var data:Object = serviceData[target];
					if (data) {
						selectMinion(data);
					} else {
						cancelSelect();
					}
				} else {
					choiceComplete();
					cancelSelect();
				}
				
			}
		}
		
		private function choiceComplete() :void {
			contextView.stage.removeEventListener(TouchEvent.TOUCH, stage_touchHandler);
			scene.removeAllMinions();
			scene.removeDarken();
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(scene);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
		}
		
		private function selectMinion (data:Object) :void {
			field.blockWeapon(weaponIndex);
			dispatch(new SceneEvent (SceneEvent.SELECT_FOR_HERO_ATTACK_INIT, { weaponIndex:weaponIndex, targetIndex:data.index } ));
		}
		
		private function cancelSelect() :void {
			hero.block = false;
			hero.stopDropShadow();
			field.glowMinions();
			hero.glow();
			hero.scaleX = hero.scaleY = 1; 
		}
	}

}