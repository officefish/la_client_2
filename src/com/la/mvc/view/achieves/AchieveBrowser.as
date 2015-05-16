package com.la.mvc.view.achieves 
{
	import com.la.event.HeroesEvent;
	import com.la.event.HeroesViewEvent;
	import com.la.mvc.model.AchieveData;
	import com.la.mvc.view.card.AchieveCard;
	import com.la.mvc.view.collection.HeroesView;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveBrowser extends Sprite 
	{
		
		private var heroesView:HeroesView;
		private var achievesView:AchievesView;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		
		public function AchieveBrowser() 
		{
			heroesView = new HeroesView ();
			achievesView = new AchievesView();
			addChild(achievesView);
			
			heroesView.addEventListener(HeroesViewEvent.SELECT, onHeroSelect); 
		}
		
		private function onHeroSelect (event:HeroesViewEvent) :void {
			dispatchEvent (new HeroesEvent (HeroesEvent.SELECT_HERO, {'hero_id':event.getHeroId()})); 
		}
				
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			heroesView.x = achievesView.x =(stageWidth - this.width) / 2;
			heroesView.y = achievesView.y =(stageHeight - this.height) / 2;
		}
		
		public function initHeroes (heroes:Array) :void {
			//if (contains(collectionView)) removeChild (collectionView);
			while (this.numChildren) removeChildAt(0);
			addChild (heroesView);
			heroesView.initHeroes (heroes);	
		}
		
		public function initHero (vocation:int) :void {
			achievesView.initHero(vocation);
		}
		
		public function initAchieves (achieves:Vector.<AchieveData>) :void {
			while (this.numChildren) removeChildAt(0);
			addChild(achievesView);
			achievesView.initAchieves(achieves);
		}
		
		public function getAchieveCardById (id:int) :AchieveCard {
			return achievesView.getAchieveCardById(id);
		}
	}

}