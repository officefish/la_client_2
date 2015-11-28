package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.FieldAbilitySlot;
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
	public class SelectTargetForAbilityCommand extends StarlingCommand 
	{
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var field:Field;
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero; 

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		private var serviceData:Dictionary;
		
		[Inject]
		public var hand:PlayerHand;
		
		[Inject]
		public var opponentHand:OpponentHand; 
		
		[Inject]
		public var scene:Scene; 
		
		private var position:int;
		
		override public function execute():void 
		{
			MonsterDebugger.log('SelectTargetForAbilityCommand::execute()');
			var slot:FieldAbilitySlot = event.data.slot;
						
			position = slot.getPosition();
			
			var associateFlag:Boolean = false;
			var opponentFlag:Boolean = false;
			var heroFlag:Boolean =  slot.getData().attachHero;
			
			if (slot.getData().attachment == 0) {
				associateFlag = true;
			} else if (slot.getData().attachment == 1) {
				opponentFlag = true;
			} else {
				associateFlag = true;
				opponentFlag = true;
			}
			
			serviceData = new Dictionary();
			var minion:IMinion;
			var index:int;
			var copy:IMinion;
			
			var associate:Vector.<IMinion>;
			
			if (associateFlag) {
				associate = field.getPlayerSpellTargetMinions();
				for (var i:int = 0; i < associate.length; i++) 
				{
					minion = associate[i];
					index = field.getPlayerMinionIndex(minion);
					copy = copyMinion(minion);
					serviceData[copy] = {'index':index, 'player':true}
				}
				if (heroFlag) {
					minion = playerHero;
					associate.push(minion);
					copy = copyMinion(minion);
					serviceData[copy] = {'index':-1, 'player':true}
				}
			}
			
			var opponent:Vector.<IMinion>
			if (opponentFlag) {
				opponent = field.getOpponentSpellTargetMinions();
				for (i = 0; i < opponent.length; i++) 
				{
					minion = opponent[i];
					index = field.getOpponentMinionIndex(minion);
					copy = copyMinion(minion);
					serviceData[copy] = {'index':index, 'player':false}
				}
				if (heroFlag) {
					minion = opponentHero;
					opponent.push(minion);
					copy = copyMinion(minion);
					serviceData[copy] = {'index':-1, 'player':false}
				}
			}
			
			if (associate.length || opponent.length ) {
				contextView.removeChildren();
				contextView.addChild(field);
				contextView.addChild(hand);
				contextView.addChild(opponentHand);
				contextView.addChild(scene);
				
				scene.darken();
				
				contextView.stage.removeEventListeners();
				contextView.stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler); 
			}
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
					cancelSelect();
					var data:Object = serviceData[target];
					if (data) {
						selectMinion(data);
					} 
				} else {
					if ((event.target as DisplayObject).name == 'darken') {
						cancelSelect ();
					}
				}
				
			}
		}
		
		protected function selectMinion (data:Object) :void {
			
			
			var serviceData:Object = { };
			if (data.player) {
				serviceData['attachment'] = 0;
			} else {
				serviceData['attachment'] = 1;
			}
			
			serviceData['targetIndex'] = data.index;
			serviceData['position'] = position;
			
			dispatch (new AbilityEvent(AbilityEvent.TARGET_FOR_ABILITY_INIT, serviceData ));
		}
		
		protected function cancelSelect() :void {
			contextView.stage.removeEventListeners();
			scene.removeAllMinions();
			scene.removeDarken();
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(scene);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
		}
		
	}

}