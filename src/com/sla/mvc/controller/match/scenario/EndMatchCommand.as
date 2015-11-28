package com.sla.mvc.controller.match.scenario 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.service.MatchService;
	import com.sla.mvc.view.field.EndMatchPopup;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.hand.OpponentHand;
	import com.sla.mvc.view.hand.PlayerHand;
	import com.sla.mvc.view.scene.Scene;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EndMatchCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var endMatchPopup:EndMatchPopup;
		
		[Inject]
		public var scene:Scene; 
		[Inject]
		public var field:Field;
		[Inject]
		public var hand:PlayerHand; 
		[Inject]
		public var opponentHand:OpponentHand;
		
		[Inject]
		public var service:MatchService;
		
		override public function execute():void 
		{
			contextView.removeChildren();
			contextView.addChild(field);
			contextView.addChild(hand);
			contextView.addChild(opponentHand);
			contextView.addChild(scene);
			
			if (event.data.client) {
				if (event.data.playerWin) {
					endMatchPopup.winMode = true;
				} else {
					endMatchPopup.winMode = false;
				}
			} else {
				if (event.data.opponentWin) {
					endMatchPopup.winMode = true;
				} else {
					endMatchPopup.winMode = false;
				}
			}
			
			scene.darken();
			field.blur();
						
			endMatchPopup.x = contextView.stage.stageWidth / 2;
			endMatchPopup.y = contextView.stage.stageHeight / 2;
			contextView.addChild(endMatchPopup);
			
			endMatchPopup.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(event:TouchEvent) :void {
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.BEGAN))  
			{
				contextView.removeChild(endMatchPopup);
				endMatchPopup.removeEventListener(TouchEvent.TOUCH, onTouch);
				scene.removeAllMinions();
				scene.removeDarken();
				field.stopBlur();
				contextView.removeChildren();
				contextView.addChild(field);
				contextView.addChild(scene);
				contextView.addChild(hand);
				contextView.addChild(opponentHand);
				service.sendMessage('end_match', {});
			}
		}
		
	}

}