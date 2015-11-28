package com.sla.mvc.controller.match.scenario.exeption 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ExceptionCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
				
		[Inject]
		public var matchModel:MatchModel; 
		
		[Inject]
		public var scene:Scene;
		
		[Inject]
		public var hand:PlayerHand;
				
		override public function execute():void 
		{
			MonsterDebugger.log ('ExceptionCommand::execute()');
			if (event.data.client) {
				scene.warning (ScenarioExeption.getWarning(event.data.exception));
				if (event.data.backCard) {
					backCard();
				} else {
					dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
				}
			} else {
				dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			}
			
			
		}
		
		private function backCard (reason:int = 0) :void {
			var card:Card = matchModel.drawingCard;
			card.getMirror().visible = true;
			var scaleX:Number = (Card.CARD_WIDTH / Card.MIRROR_WIDTH) - 0.08;
			card.x = card.position.x;
			card.y = card.position.y;
			var position:Point = new Point(card.x, card.y);
			position = card.parent.localToGlobal(position);
			contextView.stage.addChild(card.getMirror());
			var timeline:TimelineMax = new TimelineMax( { onComplete:onBackCardComplete } ); 
			timeline.to (card.getMirror(), 0.5, { x:position.x - 5, y:position.y, scaleX:scaleX, rotation:card.rotation, ease:Expo.easeInOut } );
		}
		
		private function onBackCardComplete () :void {
			var card:Card = matchModel.drawingCard;
			var mirror:Sprite = card.getMirror();
			contextView.stage.removeChild(mirror);
			mirror.scaleY = mirror.scaleX = 1;
			mirror.rotation = 0;
			card.visible = true;
			hand.glowCards(matchModel.mana, matchModel.numMinions);
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}