package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.CollectionEvent;
	import com.sla.mvc.view.card.CollectionCard;
	import com.sla.mvc.view.collection.Collection;
	import com.sla.mvc.view.scene.Scene;
	import flash.events.Event;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreviewCollectionCardCommand extends StarlingCommand 
	{
		[Inject]
		public var event:CollectionEvent;
		
		private var card:CollectionCard;
		
		[Inject]
		public var scene:Scene;
		
		private var position:Point;
		private var preview:Sprite;
		
		[Inject]
		public var collection:Collection;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('PreviewCollectionCardCommand::execute()');
			card = event.data.card;
			
			preview = card.mirror;
			
			contextView.addChild(scene);
			scene.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.darken();
			collection.blur();
			contextView.addChild(preview);
			
			var endPosition:Point = new Point ();
			endPosition.x = contextView.stage.stageWidth / 2 - 100;
			endPosition.y = contextView.stage.stageHeight / 2;
			
			position = new Point(card.x, card.y);
			position = card.parent.localToGlobal(position);
			
			preview.x = position.x;
			preview.y = position.y;
			preview.scaleX = 0.55;
			preview.scaleY = 0.55;
			preview.useHandCursor = true;
			preview.addEventListener(TouchEvent.TOUCH, onTouch);
			
			TweenLite.to (preview, 0.5, { scaleX:1.0, scaleY:1.0, x:endPosition.x, y:endPosition.y, ease:Expo.easeOut } )

		
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.BEGAN))  
			{
				endPreview();
			}
		}
		
		private function endPreview () :void {
			preview.removeEventListener(TouchEvent.TOUCH, onTouch);
			TweenLite.to (preview, 0.5, { scaleX:0.55, scaleY:0.55, alpha:0.7, x:position.x, y:position.y, ease:Expo.easeIn, onComplete:onTweenComplete } )
		}
		
		private function onTweenComplete () :void {
			scene.removeDarken();
			contextView.removeChild(scene);
			contextView.removeChild(preview);
			preview.alpha = 1;
			collection.stopBlur();
		}
		
	}

}