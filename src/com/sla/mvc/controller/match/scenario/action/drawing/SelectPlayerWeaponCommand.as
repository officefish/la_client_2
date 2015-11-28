package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.Hero;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.field.weapon.Weapon;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectPlayerWeaponCommand extends StarlingCommand 
	{
		[Inject]
		public var event:SceneEvent;
		
		private var hero:IHero;
		
		[Inject]
		public var field:Field;
		
		[Inject]
		public var scene:Scene;  
		
		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		[Inject]
		public var hand:PlayerHand; 
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		private var serviceData:Dictionary;
		
		[Inject]
		public var matchModel:MatchModel;  
		
		override public function execute():void 
		{
			hero = event.data.hero;
			hero.block = false;
			
			hand.stopGlowCards();
			field.stopGlowMinions();
			hero.stopGlow();
			hero.block = true;
			
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
			
			scene.darken();
			
			serviceData = new Dictionary();
			
			var leftWeapon:Weapon = field.getPlayerWeapon(0);
			var leftWeaponPosition:Point = new Point(leftWeapon.x, leftWeapon.y);
			leftWeaponPosition = leftWeapon.parent.localToGlobal(leftWeaponPosition);
			
			var rightWeapon:Weapon = field.getPlayerWeapon(1);
			var rightWeaponPosition:Point = new Point(rightWeapon.x, rightWeapon.y);
			rightWeaponPosition = rightWeapon.parent.localToGlobal(rightWeaponPosition);
			
			var leftWeaponClone:Weapon = leftWeapon.clone();
			leftWeaponClone.x = leftWeaponPosition.x;
			leftWeaponClone.y = leftWeaponPosition.y;
			leftWeaponClone.useHandCursor = true;
			leftWeaponClone.glow();
			serviceData[leftWeaponClone] = { 'index':0 };
			
			scene.addMinion(leftWeaponClone);
			
			var rightWeaponClone:Weapon = rightWeapon.clone();
			rightWeaponClone.x = rightWeaponPosition.x;
			rightWeaponClone.y = rightWeaponPosition.y;
			rightWeaponClone.useHandCursor = true;
			rightWeaponClone.glow();
			serviceData[rightWeaponClone] = { 'index':1 };
			
			scene.addMinion(rightWeaponClone);
			
			contextView.stage.removeEventListeners();
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
				var target:Weapon;
				if (event.target is Weapon) {
					target = event.target as Weapon;
				}
				
				if (!target && (event.target as DisplayObject).parent is Weapon) {
					target = (event.target as DisplayObject).parent as Weapon;
				}
				
				if (!target && (event.target as DisplayObject).parent.parent is Weapon) {
					target = (event.target as DisplayObject).parent.parent as Weapon;
				}
				
				if (target) {
					var data:Object = serviceData[target];
					if (data) {
						selectWeapon(data);
					} else {
						cancelSelect();
					}
				} else {
					
					if ((event.target as DisplayObject).name == 'darken') {
						cancelSelect ();
					}
				}
				
			}
		}
		
		private function selectWeapon (data:Object) :void {
			contextView.stage.removeEventListeners();
			scene.removeAllMinions();
			dispatch(new SceneEvent(SceneEvent.SELECT_TARGET_FOR_HERO_ATTACK, {hero:hero, weaponIndex:data.index}));

		}
		
		private function cancelSelect () :void {
			contextView.stage.removeEventListeners();
			scene.removeAllMinions();
			scene.removeDarken();
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(scene);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			field.glowMinions();
			hero.glow();
			hero.block = false;
			hand.glowCards(matchModel.mana, matchModel.numMinions);
		}
		
	}

}