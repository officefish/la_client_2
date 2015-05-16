package com.la.mvc.controller.match.deck 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.card.AttritionCard;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AttritionCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		override public function execute():void 
		{
			var card:DisplayObject = new AttritionCard(event.data.damage);
			var endPosition:Point = new Point (); new Point
			endPosition.x = (contextView.stage.stageWidth - card.width) / 2;
			endPosition.y = (contextView.stage.stageHeight - card.height) / 2;
			card.y = endPosition.y;
            card.x = contextView.stage.stageWidth + 100;
            scene.placeCard(card); 
			TweenLite.to (card, 1, {x:endPosition.x, y:endPosition.y, ease:Expo.easeOut, onComplete:onComplete, onCompleteParams:[card]})
		}
		
		private function onComplete (card:DisplayObject) :void {
			TweenLite.to (card, 1, {alpha:0, ease:Expo.easeOut, onComplete:onAlphaComplete})
		}
		
		private function onAlphaComplete () :void {
			scene.endPlaceCard();
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION)); 
		}		
	}

}