package com.la.mvc.controller.match.scenario.actions 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.UnitRow;
	import com.la.mvc.view.scene.IScene;
	import com.la.mvc.view.token.Token;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EnticeTokenCommand extends Command 
	{
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject]
		public var event:SceneEvent; 
		
		[Inject (name='field')]
		public var field:IField;  
		
		override public function execute():void 
		{
			console.debug ('EnticeTokenCommand::execute');
			var token:Token = event.data.targetToken as Token; 
			
			var endPosition:Point = field.placePreviewToOpponentRow(token);
						
			var tokenPosition:Point = new Point(token.x, token.y);
			tokenPosition = token.parent.localToGlobal(tokenPosition);
			
			var row:DisplayObject = token.parent;
			scene.placeCard(token);
			field.sortAndCenter(row as UnitRow);
			token.x = tokenPosition.x;
			token.y = tokenPosition.y;
			
			TweenLite.to (token, 0.9, { x:endPosition.x, y:endPosition.y, ease:Expo.easeOut, onComplete:onEnticeComplete } );
			
		}
		
		private function onEnticeComplete () :void {
			field.placeTokenToActualRow(event.data.targetToken);
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}
	}

}