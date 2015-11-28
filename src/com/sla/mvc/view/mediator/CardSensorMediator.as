package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Power0;
	import com.greensock.TweenLite;
	import com.sla.event.HandEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.card.CardSensor;
	import com.sla.mvc.view.hand.Hand;
	import com.sla.mvc.view.hand.PlayerHand;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingMediator;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import com.sla.mvc.view.scene.Scene;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardSensorMediator extends StarlingMediator 
	{
		[Inject]
		public var hand:PlayerHand;
		
		[Inject]
		public var matchModel:MatchModel;
		
		private var overFlag:Boolean = false;
		private var tweenlite:TweenLite;
		private var position:Point;
		
		override public function onRegister():void 
		{
			position = new Point();
			addViewListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch (event:TouchEvent) :void {
			
			var view:DisplayObject = this.getViewComponent() as DisplayObject;
			var card:Card = (view as CardSensor).card;
			if (card.block) return;
			
			if (event.getTouch(view, TouchPhase.HOVER)) {
				over ();
			} else {
				if (event.getTouch(view, TouchPhase.BEGAN)) {
					var touch:Touch = event.getTouch(view, TouchPhase.BEGAN)
					touch.getLocation(contextView.stage, position)
					startDrag(position);	
				} else {
					out ();
				}
			}
		}
		
		private function startDrag (position:Point) :void {
			matchModel.dragMode = true;
			overFlag = false;
			tweenlite.pause();
			var card:Card =  (this.getViewComponent() as CardSensor).card;
			dispatch(new HandEvent(HandEvent.START_DRAG, {card:card, position:position}))
			//MonsterDebugger.log ('startDrag');
		}
		
		private function over () :void {
			var card:Card;
			card = (this.getViewComponent() as CardSensor).card;
			card.x = card.longPosition.x;
			card.y = card.longPosition.y;
			card.visible = false;
			
			if (overFlag) return;
			overFlag = true;
			var mirror:Sprite = card.getMirror();
			var position:Point = new Point(card.position.x, card.position.y);
			position.y = -135;
			mirror.x = position.x;
			mirror.y = -110;
			hand.addMirror(mirror);
			if (tweenlite) {
				tweenlite.pause();
			}
			tweenlite = TweenLite.to(mirror, 2.0, { y:position.y, ease:Expo.easeOut } );
			
			
			dispatch(new HandEvent(HandEvent.CURSOR_OVER, {index:hand.getCardIndex(card)}))
			
		}
		
		private function out () :void {
			if (matchModel.dragMode) return;
			
			//MonsterDebugger.log ('sensorOut');
			var card:Card;
			overFlag = false;
			card = (this.getViewComponent() as CardSensor).card;
			card.visible = true;
			var mirror:Sprite = card.getMirror();
			mirror.y = -110;
			hand.clearMirrorStack();
			if (tweenlite) {
				tweenlite.pause();
			}
			tweenlite = TweenLite.to(card, 0.8, { x:card.position.x, y:card.position.y, ease:Expo.easeOut } );
			
			dispatch(new HandEvent(HandEvent.CURSOR_OUT, {index:hand.getCardIndex(card)}))
		}
	}

}