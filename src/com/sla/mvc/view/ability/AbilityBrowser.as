package com.sla.mvc.view.ability 
{
	import com.sla.mvc.model.data.AbilityData;
	import com.sla.mvc.view.collection.heroes.HeroesView;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityBrowser extends Sprite 
	{
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var heroesView:HeroesView; 
		private var abilitiesView:AbilitiesView;
		private var craftWiew:CraftAbilitiesView;
		
		public function AbilityBrowser() 
		{
			heroesView = new HeroesView ();
			abilitiesView = new AbilitiesView();
			craftWiew = new CraftAbilitiesView();
			
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			heroesView.resize(stageWidth, stageHeight);
			abilitiesView.resize(stageWidth, stageHeight);
			craftWiew.resize(stageWidth, stageHeight);
		}
		
		public function setup (abilities:Array) :void {
			for (var i:int = 0; i < abilities.length; i ++) {
				abilitiesView.setup(abilities[i].achieve, abilities[i].position);
			}
		}
		
		public function initAbilities (abilities:Vector.<AbilityData>) :void {
			removeChildren();
			addChild(abilitiesView);
			abilitiesView.initAbilities(abilities);
		}
		
		public function initCraftAbilities (abilities:Vector.<AbilityData>) :void {
			removeChildren();
			addChild(craftWiew);
			craftWiew.initAbilities(abilities); 
		}
		
		public function initHeroes (heroes:Array) :void {
			removeChildren();
			addChild (heroesView);
			heroesView.initHeroes (heroes);	
		}
		
		public function removeAbility(abilityId:int) :void {
			abilitiesView.removeAbility(abilityId);
		}
		
		public function addAbility(abilityId:int) :void {
			abilitiesView.addAbility(abilityId);
		}
		
		public function initHero (vocation:int) :void {
			abilitiesView.initHero(vocation);
		}
		
		public function clear () :void {
			removeChildren();
		}
		
		public function setDust (value:int) :void {
			craftWiew.setDust(value);
		}
		
		public function blur () :void {
			this.filter = new BlurFilter(1.0, 1.0, 0.5); 
		}
		public function stopBlur () :void {
			this.filter = null;
		}
		
		
		
	}

}