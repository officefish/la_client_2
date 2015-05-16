package com.la.mvc.controller.match.deck 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.scene.IScene;
	import com.ps.cards.eptitude.EptitudeAttachment;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BurnCardCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		override public function execute():void 
		{
			var card:Card = new Card(event.data.card);
			var mirror:DisplayObject = card.getMirrorBitmap ();
			var endPosition:Point = new Point ();
			endPosition.x = contextView.stage.stageWidth - (mirror.width + 100);
			endPosition.y = contextView.stage.stageHeight - (mirror.height + 100);
			mirror.y = (contextView.stage.stageHeight - mirror.height) / 2;
            mirror.x = contextView.stage.stageWidth + 100;
            scene.placeCard(mirror);
			
			var opponentFlag:Boolean = false;
			if (event.data.client) {
				if (event.data.attachment == 1) { 
					opponentFlag = true;
				}
			} else {
				if (event.data.attachment == 0) {
					opponentFlag = true;
				}
			}
						
			if (opponentFlag) {
				endPosition.y = 100;
			} 
			TweenLite.to (mirror, 1, {x:endPosition.x, y:endPosition.y, ease:Expo.easeOut, onComplete:onComplete, onCompleteParams:[mirror]})
		}
		
		private function onComplete (mirror:DisplayObject) :void {
			TweenLite.to (mirror, 1, {alpha:0, ease:Expo.easeOut, onComplete:onAlphaComplete})
		}
		
		private function onAlphaComplete () :void {
			scene.endPlaceCard();
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}