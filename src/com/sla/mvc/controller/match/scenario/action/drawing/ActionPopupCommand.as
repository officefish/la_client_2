package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.view.field.ActionPopup;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.field.PopupButton;
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
	public class ActionPopupCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var scene:Scene; 
		[Inject]
		public var field:Field; 
		[Inject]
		public var hand:PlayerHand;
		[Inject]
		public var opponentHand:OpponentHand; 
		
		private var serviceData:Dictionary;
		
		private var minion:IMinion;
		
		
		override public function execute():void 
		{
			MonsterDebugger.log ('ActionPopupCommand::execute()');
			minion = event.data.minion;

			var position:Point = minion.globalPosition;
			
			minion.block = true;
			minion.stopGlow();
			field.stopGlowMinionsExceptMinion(minion);
			
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
						
			scene.darken();
			
			serviceData = new Dictionary();
			
			var aptitudeButton:PopupButton = ActionPopup.aptitudeButton;
			aptitudeButton.x = position.x;
			aptitudeButton.y = position.y;
			scene.addMinion(aptitudeButton);
			aptitudeButton.manacost = minion.activeManacost;
			serviceData[aptitudeButton] = {index:1}
			
			if (minion.canAttack) {
				var attackButton:PopupButton = ActionPopup.attackButton;
				attackButton.x = position.x - 35;
				attackButton.y = position.y;
				scene.addMinion(attackButton);
				serviceData[attackButton] = { index:0 }
				aptitudeButton.x = position.x + 35;
			}
			
			
			
			
			contextView.stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler);
			
			
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
							
				
				var target:Sprite;
				var targetInit:Boolean = false;
				if (event.target is PopupButton) {
					target = event.target as PopupButton;
					targetInit = true;
				}
				if ((event.target as DisplayObject).parent &&
					(event.target as DisplayObject).parent is PopupButton && !targetInit) {
					target = (event.target as DisplayObject).parent as PopupButton;
					targetInit = true; 
				}
				if ((event.target as DisplayObject).parent &&
					(event.target as DisplayObject).parent.parent &&
					(event.target as DisplayObject).parent.parent is PopupButton && !targetInit) {
					target = (event.target as DisplayObject).parent.parent as PopupButton;
					targetInit = true;
				}
				
				if (target)
				{
					choiceComplete();
					var data:Object = serviceData[target];
					if (data) {
						select(data);
					} else {
						cancelSelect();
					}
					
				} else {
					
					var iniciator:IMinion;
					if (event.target is IMinion) {
						iniciator = event.target as IMinion;
						targetInit = true; 
					}
					if ((event.target as DisplayObject).parent &&
						(event.target as DisplayObject).parent is IMinion && !targetInit) {
						iniciator = (event.target as DisplayObject).parent as IMinion;
						targetInit = true;
					}
					if ((event.target as DisplayObject).parent &&
						(event.target as DisplayObject).parent.parent &&
						(event.target as DisplayObject).parent.parent is IMinion && !targetInit) {
						iniciator = (event.target as DisplayObject).parent.parent as IMinion;
						targetInit = true;
					}
					if ((event.target as DisplayObject).parent &&
						(event.target as DisplayObject).parent.parent &&
						(event.target as DisplayObject).parent.parent.parent &&
						(event.target as DisplayObject).parent.parent.parent is IMinion && !targetInit) {
						iniciator = (event.target as DisplayObject).parent.parent.parent as IMinion;
						targetInit = true;
					}
					if (iniciator) {
						return;
					}
					
					choiceComplete();
					cancelSelect();
				}
				
			}
		}
		
		public function choiceComplete () :void {
			contextView.stage.removeEventListener(TouchEvent.TOUCH, stage_touchHandler);
			scene.removeAllMinions();
			scene.removeDarken();
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(scene);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
		}
		
		public function select (data:Object) :void {
			

			if (data.index) {
				var initiatorIndex:int = minion.asDO().parent.getChildIndex(minion.asDO());
				dispatch(new SceneEvent(SceneEvent.ACTIVATE_ACTIVE, { index:initiatorIndex } ));
			} else {
				dispatch(new SceneEvent(SceneEvent.INIT_ATTACK_TARGET, { minion:minion } ));
			}
		}
		
		public function cancelSelect () :void {
			minion.block = false;
			field.glowMinions();
		}
		
		
	}

}