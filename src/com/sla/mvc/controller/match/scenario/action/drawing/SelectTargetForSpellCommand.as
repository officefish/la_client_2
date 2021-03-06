package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.sla.event.HandEvent;
	import com.sla.event.ScenarioEvent;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.card.Card;
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
	public class SelectTargetForSpellCommand extends StarlingCommand
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var field:Field;
		
		[Inject]
		public var scene:Scene;
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero;

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		[Inject]
		public var hand:PlayerHand; 
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		private var serviceData:Dictionary; 
		
		[Inject]
		public var matchModel:MatchModel;  
		
		private var card:Card;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('SelectTargetForSpellCommand::execute()');
			
			if (!event.data.client) {
				dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
				return;
			}
			
			card = matchModel.drawingCard;
			var cardIndex:int = event.data.index; 
			
			card.getMirror().visible = false;
			
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
			
			var associate:Array = event.data.mask.associate;
			var opponent:Array = event.data.mask.opponent;
			var playerHeroFlag:Boolean = event.data.mask.player_hero;
			var opponentHeroFlag:Boolean = event.data.mask.opponent_hero;
						
			var index:int;
			var minion:IMinion;
			var copy:IMinion;
			
			scene.darken();
			
			serviceData = new Dictionary();
			
			for (var i:int = 0; i < associate.length; i++) {
				index = associate[i]
				minion = field.getMinion(index, true);
				if (minion.isSpellInvisible) continue;
				copy = copyMinion(minion);
				serviceData[copy] = {'index':index, 'player':true}
			}
			
			for (i = 0; i < opponent.length; i++) {
				index = opponent[i]
				minion = field.getMinion(index, false);
				if (minion.isSpellInvisible) continue;
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
		
		private function selectMinion (data:Object) :void {
			var attachment:int = 0;
			if (data.player == false) {
				attachment = 1;
			}
			var serviceData:Object = { };
			serviceData['attachment'] = attachment
			serviceData['index'] = data.index;
			dispatch (new SceneEvent(SceneEvent.SELECT_FOR_SPELL_INIT, serviceData));
		}
		
		private function cancelSelect() :void {
			backCardToHand();
		}
		
		private function backCardToHand () :void {
			var scaleX:Number = (Card.CARD_WIDTH / Card.MIRROR_WIDTH) - 0.08;
			card.x = card.position.x;
			card.y = card.position.y;
			var position:Point = new Point(card.x, card.y);
			position = card.parent.localToGlobal(position);
			var mirror:DisplayObject = card.getMirror();
			mirror.visible = true; 
			var timeline:TimelineMax = new TimelineMax( { onComplete:onBackCardComplete } ); 
			timeline.to (mirror, 0.5, { x:position.x - 5, y:position.y, scaleX:scaleX, rotation:card.rotation, ease:Expo.easeInOut } );
		}
		
		private function onBackCardComplete () :void {
			var mirror:DisplayObject = card.getMirror();
			contextView.stage.removeChild(mirror);
			mirror.scaleY = mirror.scaleX = 1;
			mirror.rotation = 0;
			card.visible = true;
			card.block = false;
			matchModel.dragMode = false;
			hand.glowCards(matchModel.mana, matchModel.numMinions);
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
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
	}

}