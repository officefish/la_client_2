package com.sla.mvc.controller.match.hand 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.greensock.TweenLite;
	import com.sla.event.FieldEvent;
	import com.sla.event.HandEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.hand.PlayerHand;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartDragCardCommand extends StarlingCommand 
	{
		[Inject]
		public var event:HandEvent;
		
		[Inject]
		public var matchModel:MatchModel; 
		
		[Inject]
		public var rootModel:RootModel; 
		
		[Inject]
		public var hand:PlayerHand;
		
		private var mirror:Sprite;
		private var helperPoint:Point = new Point(); 
		
		private var validFlag:Boolean = false;
		private var validZone:int;
		private var timeline:TimelineMax;
		private var scaleX:Number;
		private var scaleY:Number;
		private var card:Card;
		private var fieldPositionFlag:Boolean = false;
		private var dragMode:Boolean = false;

		
		override public function execute():void 
		{
			MonsterDebugger.log('StartDragCommand::execute()');
			hand.stopGlowCards();
			
			card = event.data.card;
			matchModel.drawingCard = card;
			mirror = card.getMirror();
			scaleX = Card.CARD_WIDTH / Card.MIRROR_WIDTH;
			scaleY = Card.CARD_HEIGHT/ Card.MIRROR_HEIGHT;
			
			var startPosition:Point = new Point(mirror.x, mirror.y);
			startPosition = mirror.parent.localToGlobal(startPosition);
			contextView.stage.addChild(mirror);
			mirror.x = startPosition.x;
			mirror.y = startPosition.y;
			
			validZone = contextView.stage.stageHeight - 180;
			
			dragMode = true;
						
			var position:Point = event.data.position;
			timeline = new TimelineMax();
			timeline.to (mirror, 0.5, { scaleX:scaleX, scaleY:scaleY, x:position.x, y:position.y, ease:Expo.easeInOut } );
			Starling.current.stage.addEventListener(TouchEvent.TOUCH, stage_touchHandler);
		}
		
		private function validate () :void {
			validFlag = true;
			if (matchModel.block) {
				backCard();
				return;
			}
			if (matchModel.mana < card.getCardData().price) {
				backCard();
				return;
			}
			
			
			if (card.getCardData().type == CardData.UNIT && matchModel.numMinions >= 7) {
				backCard();
				return;
			}
			
			
		}
		
		private function backCard (reason:int = 0) :void {
			dragMode = false;
			Starling.current.stage.removeEventListener(TouchEvent.TOUCH, stage_touchHandler);
			scaleX = (Card.CARD_WIDTH / Card.MIRROR_WIDTH) - 0.08;
			//var clientId:String = rootModel.lobbyId + " :: " 
			//MonsterDebugger.log(clientId + 'backCard');
			card.x = card.position.x;
			card.y = card.position.y;
			var position:Point = new Point(card.x, card.y);
			position = card.parent.localToGlobal(position);
			
			timeline = new TimelineMax( { onComplete:onBackCardComplete } );
			timeline.to (mirror, 0.5, { x:position.x - 5, y:position.y, scaleX:scaleX, rotation:card.rotation, ease:Expo.easeInOut } );
		}
		
		private function onBackCardComplete () :void {
			contextView.stage.removeChild(mirror);
			mirror.scaleY = mirror.scaleX = 1;
			mirror.rotation = 0;
			card.visible = true;
			matchModel.dragMode = false;
			hand.glowCards(matchModel.mana, matchModel.numMinions);
		}
		
		private function stage_touchHandler(event:TouchEvent):void
		{
			
			var touch:Touch = event.getTouch(contextView.stage, null, -1);
			if(!touch)
			{
				return;
			}
			if(touch.phase == TouchPhase.MOVED)
			{
				if (timeline) {
					timeline.pause();
					mirror.scaleX = scaleX;
					mirror.scaleY = scaleY;
					timeline = null;
				}
				
				touch.getLocation(contextView.stage, helperPoint);
				mirror.x = helperPoint.x;
				mirror.y = helperPoint.y; 
				
				if (mirror.y < validZone && !validFlag) {
					validate();
				}
				
				if (mirror.y < validZone && !fieldPositionFlag) {
					findPosition();
				}
				
				if (mirror.y >= validZone && fieldPositionFlag) {
					stopFindPosition(true);
				}
				
			}
			
			else if(touch.phase == TouchPhase.ENDED)
			{
				touch.getLocation(contextView.stage, helperPoint);
				if (mirror.y >= validZone) {
					backCard();
				} else {
					playCard();
				}
			}
		}
		
		private function findPosition () :void {
			if (matchModel.block) {
				return;
			}
			
			if (dragMode == false) {
				return;
			}
			
			if (card.getCardData().type != CardData.UNIT) {
				return;
			}
			
			fieldPositionFlag = true;
			dispatch(new FieldEvent(FieldEvent.FIND_MINION_POSITION));
		}
		
		private function stopFindPosition (sortFlag:Boolean) :void {
				
			if (card.getCardData().type != CardData.UNIT) {
				return;
			}
			
			fieldPositionFlag = false;
			dispatch(new FieldEvent(FieldEvent.STOP_FIND_MINION_POSITION, {sort:sortFlag}));
		}
		
		private function playCard () :void {
			stopFindPosition(false);
			dragMode = false;
			Starling.current.stage.removeEventListener(TouchEvent.TOUCH, stage_touchHandler);
			
			//contextView.stage.removeChild(mirror);
			//mirror.scaleY = mirror.scaleX = 1;
			//mirror.rotation = 0;
			
			matchModel.dragMode = false;
			var index:int = hand.getCardIndex(card);
			switch (card.getCardData().type) {
				case CardData.UNIT: {
					dispatch(new HandEvent(HandEvent.PLAY_CARD, { card:card, index:index } ));
					break;
				}
				case CardData.SPELL: {
					dispatch(new HandEvent(HandEvent.PLAY_CARD, { card:card, index:index } ));
					break;
				}
				case CardData.SPELL_TO_TARGET: {
					dragMode = false;
					Starling.current.stage.removeEventListener(TouchEvent.TOUCH, stage_touchHandler);
					dispatch(new HandEvent(HandEvent.SELECT_TARGET_FOR_SPELL, { card:card, index:index } ));
					break;
				}
			}
		}
		
		
	}

}