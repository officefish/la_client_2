package com.sla.mvc.controller.match.scenario.action.drawing 
{
	import com.greensock.easing.Expo;
	import com.greensock.TimelineMax;
	import com.sla.event.ScenarioEvent;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.card.Card;
	import flash.geom.Point;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectTargetForEffectCommand extends SelectTargetForAptitudeCommand
	{
		[Inject]
		public var model:MatchModel;
		
		private var mirror:Sprite;
		
		private var card:Card;
		
		override protected function selectMinion(data:Object):void 
		{
			var attachment:int = 0;
			if (data.player == false) {
				attachment = 1;
			}
			var serviceData:Object = { };
			serviceData['attachment'] = attachment
			serviceData['targetIndex'] = data.index;
			dispatch (new SceneEvent(SceneEvent.TARGET_FOR_EFFECT_SELLECTED, serviceData));
			
		}
		
		override protected function cancelSelect():void 
		{
			card = model.drawingCard;
			mirror = card.getMirror();
			mirror.visible = true;
			var scaleX:Number = (Card.CARD_WIDTH / Card.MIRROR_WIDTH) - 0.08;
			card.x = card.position.x;
			card.y = card.position.y;
			var position:Point = new Point(card.x, card.y); 
			position = card.parent.localToGlobal(position);
			var timeline:TimelineMax = new TimelineMax( { onComplete:onBackCardComplete } ); 
			timeline.to (mirror, 0.5, { x:position.x - 5, y:position.y, scaleX:scaleX, rotation:card.rotation, ease:Expo.easeInOut } );
		}
		
		private function onBackCardComplete () :void {
			if (mirror.parent && mirror.parent.contains(mirror)) {
				mirror.parent.removeChild(mirror);
			}
			mirror.scaleY = mirror.scaleX = 1;
			mirror.rotation = 0;
			card.visible = true;
			card.block = false;
			model.block = false;
			hand.glowCards(model.mana, model.numMinions);
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}