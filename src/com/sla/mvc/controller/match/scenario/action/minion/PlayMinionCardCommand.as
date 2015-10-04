package com.sla.mvc.controller.match.scenario.action.minion {
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.Minion;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PlayMinionCardCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var field:Field;
		
		[Inject]
		public var playerHand:PlayerHand;
		
		[Inject]
		public var opponentHand:OpponentHand;
		
		private var timeline:TimelineMax;
		private var minion:Minion;
		private var mirror:Sprite;
		private var card:Card;
		
		[Inject]
		public var matchModel:MatchModel;
		
		
		override public function execute():void 
		{
			MonsterDebugger.log('PlayMinionCardCommand::execute()')
			var client:Boolean = event.data.client;
			if (client) {
				//playerHand.stopGlowCards();
				card = playerHand.getCard(event.data.cardIndex);
			} else {
				card = opponentHand.getCard(event.data.cardIndex);
			}
			MonsterDebugger.log('position:' + event.data.position);
			minion = field.addMinion(event.data.cardData, event.data.position, client);
			minion.alpha = 0;
			var minionX:int = field.getMinionPosition(event.data.position);
			var minionPosition:Point = new Point (minionX, 0);
			minionPosition = minion.parent.localToGlobal(minionPosition);
			
			
			if (client) {
				timeline = new TimelineMax({onComplete:onPlayerPrepareComplete});
				playerHand.removeCard(card);
				mirror = card.getMirror();
				timeline.to(mirror, 0.5, {x:minionPosition.x, y:minionPosition.y, ease:Expo.easeOut});
			} else {
				//
				timeline = new TimelineMax({onComplete:onOpponentPrepareComplete});
				var cardPosition:Point = new Point(card.x, card.y);
				cardPosition = card.parent.localToGlobal(cardPosition);
				opponentHand.removeCard(card);
				card.x = cardPosition.x;
				card.y = cardPosition.y;
				contextView.addChild(card);
				timeline.to(card, 0.5, {x:minionPosition.x, y:minionPosition.y, rotation:0, ease:Expo.easeOut});

			}
		}	
		
		private function onPlayerPrepareComplete () :void { 
			// some cool animation here
			timeline = new TimelineMax({onComplete:animationComplete});
			timeline.add('spin');
			timeline.to (mirror, 0.8, { alpha:0, ease:Expo.easeInOut }, 'spin');
			timeline.to (minion, 0.8, { alpha:1, ease:Expo.easeInOut }, 'spin');
		}
		
		private function onOpponentPrepareComplete () :void { 
			// some cool animation here
			timeline = new TimelineMax({onComplete:animationComplete});
			timeline.add('spin');
			timeline.to (card, 0.8, { alpha:0, ease:Expo.easeInOut }, 'spin');
			timeline.to (minion, 0.8, { alpha:1, ease:Expo.easeInOut }, 'spin');
		}
		
		private function animationComplete () :void {
			if (mirror && mirror.parent) {
				mirror.parent.removeChild(mirror);
			}
			if (card.parent) {
				card.parent.removeChild(card);
			}
			matchModel.numMinions = field.numMinions;
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}