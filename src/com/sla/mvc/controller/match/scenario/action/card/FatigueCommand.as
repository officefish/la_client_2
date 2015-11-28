package com.sla.mvc.controller.match.scenario.action.card 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.card.FatigueCard;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FatigueCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			var card:Sprite = new FatigueCard(event.data.damage);
			var endPosition:Point = new Point();
			endPosition.x = contextView.stage.stageWidth / 2;
			endPosition.y = contextView.stage.stageHeight / 2;
			card.y = endPosition.y;
            card.x = contextView.stage.stageWidth + 100;
            scene.addMinion(card);  
			TweenLite.to (card, 1, {x:endPosition.x, y:endPosition.y, ease:Expo.easeOut, onComplete:onComplete, onCompleteParams:[card]})
		}
		
		private function onComplete (card:Sprite) :void {
			TweenLite.to (card, 1, {alpha:0, ease:Expo.easeOut, onComplete:onAlphaComplete})
		}
		
		private function onAlphaComplete () :void {
			scene.removeAllMinions();
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION)); 
		}		
	}

}