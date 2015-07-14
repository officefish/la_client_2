package com.la.mvc.controller.achieves 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.ApiServiceEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.achieves.AchieveBrowser;
	import com.la.mvc.view.achieves.CraftAchieveWidget;
	import com.la.mvc.view.card.AchieveCraftCard;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveCraftCompleteCommand extends Command 
	{
		
		[Inject (name = 'achieves')]
		public var achieves:AchieveBrowser; 
		
		[Inject]
		public var event:ApiServiceEvent; 
		
		[Inject (name = 'craftAchieveWidget')]
		public var craftWidget:CraftAchieveWidget;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel;
		
		private var card:AchieveCraftCard;
		private var item:Sprite;
		
		override public function execute():void 
		{
			model.setDust (event.getData().dust);
			achieves.setDust (event.getData().dust);
			
			card = achieves.getAchieveCraftCardById(event.getData()['achieveId']);
			item =  card.getMirrorBitmapCopy();
			item.removeEventListener(MouseEvent.CLICK, model.getPreviewFunction());
			var position:Point = new Point(item.x, item.y);
						
			card.setCount(event.getData().count);
			contextView.removeChild (item);
			//card.setState(AchieveCraftCard.DEFAULT_STATE);
			
			
			item =  card.getMirrorBitmapCopy();
			item.addEventListener (MouseEvent.CLICK, onPreviewClick);  
			item.x = position.x;
			item.y = position.y;
			contextView.addChild(item);
			craftWidget.unblock();
			
			if (card.getData().count >= card.getData().max_access) {
				craftWidget.blockCraftButton();
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