package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectEffectCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var scene:Scene;
		[Inject]
		public var field:Field;
		[Inject]
		public var hand:PlayerHand; 
		[Inject]
		public var opponentHand:OpponentHand;
		
		[Inject]
		public var model:MatchModel;  
		
		private var mirrors:Vector.<Sprite>;
		
		override public function execute():void 
		{
			if (!event.data.client) {
				dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
				return;
			}
			
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
			
			model.drawingCard.getMirror().visible = false;
						
			
			var cardDatas:Array = event.data.cards;
			
			var endX:int;
			var cardsWidth:int = cardDatas.length * Card.MIRROR_WIDTH;
			cardsWidth += (cardDatas.length - 1) * 20;
			var endX_Base:int = (contextView.stage.stageWidth - cardsWidth) / 2; 
			
			scene.darken();
			mirrors = new Vector.<Sprite>();
			
			for (var i:int = 0; i < cardDatas.length; i ++) {
				var card:Card = new Card (cardDatas[i]);
				card.setSpellMixin(model.getSpellMixin());
				var mirror:Sprite = card.getMirror();
				mirror.useHandCursor = true;
				scene.addMinion(mirror);
				endX = endX_Base;
				endX += (Card.MIRROR_WIDTH + 20) * i + Card.MIRROR_WIDTH / 2;
				mirror.x = endX;
				mirror.y = contextView.stage.stageHeight / 2;
				
				mirrors.push(mirror);
				mirror.addEventListener(TouchEvent.TOUCH, onTouch); 
			}
		}
		
		private function onTouch (event:TouchEvent) :void {
			var mirror:Sprite = event.currentTarget as Sprite;	
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER)) {  
				mirror.filter = glowFilter;
			} else {
				mirror.filter = null;
			}
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.BEGAN))
			{
				var index:int = mirrors.indexOf(event.currentTarget);
				choiceComplete(index);
			}
		}
		
		private function choiceComplete(index:int) :void {
			removeListeners();
			scene.removeAllMinions();
			scene.removeDarken();
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(scene);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			dispatch (new SceneEvent (SceneEvent.EFFECT_SELECTED, { index:index } ));
		}
		
		private function removeListeners () :void {
			var mirror:Sprite;
			for (var i:int = 0; i < mirrors.length; i ++) {
				mirror = mirrors[i];
				mirror.removeEventListeners();
			}
		}
		
		private static var _glowWilter:BlurFilter; 
		private static function get glowFilter () :BlurFilter {
			if (!_glowWilter) {
				_glowWilter = BlurFilter.createGlow(0x00FFFF, 1, 3, .5);
			}
			return _glowWilter;
		}
		
	}

}