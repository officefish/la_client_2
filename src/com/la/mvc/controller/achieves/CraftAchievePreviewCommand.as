package com.la.mvc.controller.achieves 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.CardEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.mvc.view.achieves.CraftAchieveWidget;
	import com.la.mvc.view.card.AchieveCraftCard;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftAchievePreviewCommand extends Command 
	{
		[Inject]
		public var event:CardEvent;
		
		private var card:AchieveCraftCard;
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		private var item:Sprite;
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (name = 'achieves')]
		public var achieves:AchieveBrowser; 
		
		[Inject (name = 'craftAchieveWidget')]
		public var craftWidget:CraftAchieveWidget;
		
		override public function execute():void 
		{
			rootModel.currentState = GameState.HEROES_PREVIEW;
			
			card = event.data.card as AchieveCraftCard;
			
			craftWidget.setAchieveId(card.getData().id);
		
			item =  card.getMirrorBitmapCopy();
			item.scaleX = 0.3;
			item.scaleY = 0.3;
			item.buttonMode = true;
			item.addEventListener (MouseEvent.CLICK, onPreviewClick); 
			model.setPreviewFunction(onPreviewClick);
			
			var startPosition:Point = new Point(card.x, card.y);
			startPosition = card.parent.localToGlobal(startPosition);
			
			item.x = startPosition.x;
			item.y = startPosition.y;
			
			var endPosition:Point = new Point ();
			endPosition.x = (contextView.stage.stageWidth - AchieveCraftCard.MIRROR_WIDTH) / 2 - 70;
			endPosition.y = (contextView.stage.stageHeight - AchieveCraftCard.MIRROR_HEIGHT) / 2 - 50;
			
			contextView.addChild (scene as DisplayObject); 
			contextView.addChild (item);
			
			TweenLite.to (item, 0.5, { scaleX:1.0, scaleY:1.0, x:endPosition.x, y:endPosition.y, ease:Expo.easeOut } )
			
			scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.darken();
			
			achieves.blur();
						
			contextView.addChild (craftWidget);
			craftWidget.x = endPosition.x;
			craftWidget.y = endPosition.y + 370;
			
			var craftPrice:int = card.getData().buyCost;
			var destroyPrice:int = card.getData().saleCost;
			craftWidget.setPrices (craftPrice, destroyPrice);
			
			craftWidget.unblock();
			
			trace('count: ' + card.getData().count)
			trace('maxAccess: ' + card.getData().max_access)
			
			if (card.getData().count >= card.getData().max_access) {
				craftWidget.blockCraftButton();
			} 
			
			if (card.getData().count < 1) {
				craftWidget.blockDestroyButton();
			}
			
		}	
		
		private function onPreviewClick (event:MouseEvent) :void {
			if (contextView.contains(craftWidget)) {
				contextView.removeChild (craftWidget);
			}
			scene.lighten(false);
			achieves.stopBlur();
			item.removeEventListener (MouseEvent.CLICK, onPreviewClick);
			var endPosition:Point = new Point (card.x, card.y);
			endPosition = card.parent.localToGlobal (endPosition);
			endPosition.x += (card.width / 2);
			endPosition.y += (card.height / 2);
			TweenLite.to (item, 0.4, {scaleX:0.02, scaleY:0.02, x:endPosition.x, y:endPosition.y, ease:Expo.easeIn, onComplete:onTweenComplete } )
		}
		
		private function onTweenComplete () :void {
			contextView.removeChild (item);
			rootModel.currentState = GameState.HEROES;

		}
	}

}