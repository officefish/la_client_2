package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenLite;
	import com.sla.event.ScenarioEvent;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.field.MinionPosition;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import starling.events.TouchEvent;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectTargetForAptitudeCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var field:Field;
		
		[Inject]
		public var scene:Scene;
		
		private var serviceData:Dictionary;
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero;

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		[Inject]
		public var hand:PlayerHand;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('SelectTargetForAptitudeCommand::execute()');
			
			if (!event.data.client) {
				dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
				return;
			}
			
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
						
			var associate:Array = event.data.mask.associate;
			var opponent:Array = event.data.mask.opponent;
			var playerHeroFlag:Boolean = event.data.mask.player_hero;
			var opponentHeroFlag:Boolean = event.data.mask.opponent_hero;
			
			//MonsterDebugger.log('associate: ' + associate.length);
			//MonsterDebugger.log('opponent: ' + opponent.length);
			//MonsterDebugger.log('playerHero: ' + playerHeroFlag);
			//MonsterDebugger.log('opponentHeroFlag: ' + opponentHeroFlag);
			
			scene.darken();
			// field.blur();
			
			serviceData = new Dictionary();
			
			var index:int;
			var minion:IMinion;
			var copy:IMinion;
			
			for (var i:int = 0; i < associate.length; i++) {
				index = associate[i]
				minion = field.getMinion(index, true);
				copy = copyMinion(minion);
				serviceData[copy] = {'index':index, 'player':true}
			}
			
			for (i = 0; i < opponent.length; i++) {
				index = opponent[i]
				minion = field.getMinion(index, false);
				copy = copyMinion(minion);
				serviceData[copy] = {'index':index, 'player':false}
			}
			if (playerHeroFlag) {
				minion = playerHero;
				copy = copyMinion(minion);
				serviceData[copy] = {'index':-1, 'player':true}
			}
			if (opponentHeroFlag) {
				minion = opponentHero;
				copy = copyMinion(minion);
				serviceData[copy] = {'index':-1, 'player':false}
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
			//contextView.stage.addChild(copyDO);
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
				choiceComplete();
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
					var data:Object = serviceData[target];
					if (data) {
						selectMinion(data);
					} else {
						cancelSelect();
					}
				} else {
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
		
		protected function selectMinion (data:Object) :void {
			dispatch (new SceneEvent(SceneEvent.SELECT_FOR_APTITUDE_INIT, { serviceData:data } ));
		}
		
		protected function cancelSelect() :void {
			dispatch (new SceneEvent(SceneEvent.CANCEL_SELECT_FOR_APTITUDE_UNIT, {}));
		}
		
		
	}

}