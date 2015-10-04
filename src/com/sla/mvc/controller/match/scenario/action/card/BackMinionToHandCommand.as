package com.sla.mvc.controller.match.scenario.action.card 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BackMinionToHandCommand extends MinionActionCommand
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var playerHand:PlayerHand; 
		
		[Inject]
		public var opponentHand:OpponentHand; 
		
		private var playerFlag:Boolean = true;
		private var movingDO:DisplayObject;
		private var minion:IMinion;
		private var card:Card;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('BackCardToHandCommand::execute()');
			super.execute();
			
			
			var index:int = event.data.targetIndex;
			var attachment:int = event.data.targetAttachment;
			var client:Boolean = event.data.client;
			var cardData:CardData = event.data.cardData;
			var startPosition:Point;
			var endPosition:Point;
			
			minion = this.initMinionByAttachment(index, attachment, client);
			var minionDO:DisplayObject = minion.asDO();
			if (!minionDO) {
				// выходим снова к общему сценарию
				//minionDO.y += 30;
			}
			if (client) {
				if (attachment) {
					playerFlag = true;
				} else {
					playerFlag = false;
				}
			} else {
				if (attachment) {
					playerFlag = false;
				} else {
					playerFlag = true;
				}
			}
			
			if (playerFlag) {
				card = playerHand.addCard(cardData, false); 
				movingDO = card.getMirror();
			} else {
				card = opponentHand.addCard(cardData, false);
				movingDO = card.getShirt();
			}
			card.visible = false;
			
			startPosition = new Point (minionDO.x, minionDO.y);
			startPosition = minionDO.parent.localToGlobal(startPosition);
			
			movingDO.x = startPosition.x;
			movingDO.y = startPosition.y;
			var scaleX:Number = (Card.CARD_WIDTH / Card.MIRROR_WIDTH);
			var scaleY:Number = Card.CARD_HEIGHT/ Card.MIRROR_HEIGHT;
			movingDO.scaleX = scaleX;
			movingDO.scaleY = scaleY;
			var endScaleX:Number = scaleX - 0.08;
			contextView.stage.addChild(movingDO);
			
			endPosition = card.position;
			endPosition = card.parent.localToGlobal(endPosition);
			
			minionDO.visible = false;
			var timeline:TimelineMax = new TimelineMax({onComplete:endAnimation});
			timeline.add ('spin');
			timeline.to (movingDO, 0.7, { y:startPosition.y - 40, ease:Expo.easeOut, onComplete:removeMinion }, 'spin');
			timeline.to (movingDO, 0.5, { delay:0.7, x:endPosition.x, y:endPosition.y, rotation:card.endRotation, ease:Expo.easeIn } , 'spin');
			
		}	
		
		private function removeMinion () :void {
			field.removeMinion(minion);
		}
		
		private function endAnimation () :void {
			contextView.stage.removeChild(movingDO);
			card.visible = true;
			movingDO.scaleX = 1;
			movingDO.scaleY = 1;
			movingDO.rotation = 0;
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}