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
	public class AchievesCraftListInitCommand extends Command 
	{
		[Inject (name = 'achieves')]
		public var achieves:AchieveBrowser; 
		
		[Inject]
		public var event:ApiServiceEvent; 
				
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		
		
		 
			
		override public function execute():void 
		{
			achieves.initCraftAchieves(event.getData()['achieves'])
			model.setDust (event.getData().dust);
			achieves.setDust (event.getData().dust);
		}
		
		
	}

}