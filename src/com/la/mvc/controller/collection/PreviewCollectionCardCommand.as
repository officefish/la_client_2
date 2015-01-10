package com.la.mvc.controller.collection 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.CollectionCard;
	import com.la.mvc.view.collection.ICollection;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreviewCollectionCardCommand extends Command 
	{
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		private var item:Sprite;

		
		override public function execute():void 
		{
			rootModel.currentState = GameState.COLLECTION_PREVIEW;
			var card:CollectionCard = model.collectionCard;
			
			item =  new Sprite();
			item.addChild(card.getMirrorBitmap()); 
			item.scaleX = 0.3;
			item.scaleY = 0.3;
			item.buttonMode = true;
			item.addEventListener (MouseEvent.CLICK, onPreviewClick);
			
			item.x = card.x + card.parent.x + (collection as DisplayObject).x;
			item.y = card.y + card.parent.y + (collection as DisplayObject).y;
			
			var endPosition:Point = new Point ();
			endPosition.x = (contextView.stage.stageWidth - CollectionCard.MIRROR_WIDTH) / 2 - 70;
			endPosition.y = (contextView.stage.stageHeight - CollectionCard.MIRROR_HEIGHT) / 2 - 50;
			
			contextView.addChild (scene as DisplayObject);
			contextView.addChild (item);
			
			TweenLite.to (item, 0.5, { scaleX:1.0, scaleY:1.0, x:endPosition.x, y:endPosition.y, ease:Expo.easeOut } )
			
			scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.darken();
			collection.blur();
		}
		
		private function onPreviewClick (event:MouseEvent) :void {
			scene.lighten(false);
			collection.stopBlur();
			item.removeEventListener (MouseEvent.CLICK, onPreviewClick);
			var card:CollectionCard = model.collectionCard;
			var endPosition:Point = new Point (card.x, card.y);
			endPosition = card.parent.localToGlobal (endPosition);
			endPosition.x += (card.width / 2);
			endPosition.y += (card.height / 2);
			TweenLite.to (item, 0.4, {scaleX:0.02, scaleY:0.02, x:endPosition.x, y:endPosition.y, ease:Expo.easeIn, onComplete:onTweenComplete } )
		}
		
		private function onTweenComplete () :void {
			contextView.removeChild (item);
			rootModel.currentState = GameState.COLLECTION;

		}
		
		
		
		
		
	}

}