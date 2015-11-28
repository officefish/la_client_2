package com.sla.mvc.controller.match.scenario.action.card 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BurnCardCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var scene:Scene;  
				
		override public function execute():void 
		{
			MonsterDebugger.log('BurnCardCommand::execute()');
			
			var card:Card = new Card(event.data.card); 
			var mirror:Sprite = card.getMirror();
			var endPosition:Point = new Point (); 
			endPosition.x = contextView.stage.stageWidth - 300;
			endPosition.y = contextView.stage.stageHeight / 2 + (Card.MIRROR_HEIGHT * 0.5); ;
			mirror.y = contextView.stage.stageHeight/2  + (Card.MIRROR_HEIGHT);
            mirror.x = contextView.stage.stageWidth;
            scene.addMinion(mirror);
			
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
				mirror.y = contextView.stage.stageHeight/2  - (Card.MIRROR_HEIGHT);
				endPosition.y = contextView.stage.stageHeight / 2 - (Card.MIRROR_HEIGHT * 0.5); 
			}  
			
			TweenLite.to (mirror, 1, {x:endPosition.x, y:endPosition.y, ease:Expo.easeOut, onComplete:onComplete, onCompleteParams:[mirror]})
		}	
		
		private function onComplete (mirror:DisplayObject) :void {
			TweenLite.to (mirror, 1, {alpha:0, ease:Expo.easeOut, onComplete:onAlphaComplete})
		}
		
		private function onAlphaComplete () :void {
			scene.removeAllMinions();
			dispatch (new ScenarioEvent(ScenarioEvent.ACTION));
		}
	}

}