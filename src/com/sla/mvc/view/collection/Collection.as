package com.sla.mvc.view.collection {
	import com.sla.event.starling.StarlingDeckListEvent;
	import com.sla.mvc.model.data.DeckData;
	import com.sla.mvc.model.data.HeroData;
	import com.sla.mvc.view.card.CollectionCard;
	import com.sla.mvc.view.collection.heroes.HeroesView;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Collection extends Sprite 
	{
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var collectionView:CollectionView;
		private var heroesView:HeroesView;
		
		private var blockQuad:Quad
		
		public function Collection() 
		{
			collectionView = new CollectionView ();
			addChild (collectionView);
			
			heroesView = new HeroesView();
			
			blockQuad = new Quad(800, 600, 0x222222);
			blockQuad.alpha = 0.7;
			
			
		}
		
		public function darken () :void {
			addChild(blockQuad);
		}
		
		public function stopDarken () :void {
			if (contains(blockQuad)) removeChild(blockQuad);
		}
		
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			collectionView.x =  (stageWidth - 800) / 2;
			collectionView.y = (stageHeight - 600) / 2;
			
			heroesView.resize(stageWidth, stageHeight);
			
			blockQuad.x = collectionView.x;
			blockQuad.y = collectionView.y;
			
			
		}
		
		public function blur () :void {
			this.filter = new BlurFilter(1.0, 1.0, 0.5); 
		}
		public function stopBlur () :void {
			this.filter = null;
		}
		
		public function initBooks (books:Array) :void {
			if (contains(heroesView)) removeChild (heroesView);
			addChild (collectionView);
			collectionView.initBooks (books);
		}
		
		public function initDecks (decks:Array) :void {
			collectionView.initDecks(decks);
		}
		
		public function initHeroes (heroes:Array) :void {
			if (contains(collectionView)) removeChild (collectionView);
			addChild (heroesView);
			heroesView.initHeroes (heroes);	
		}
		
		public function setState (value:int) :void {
			collectionView.setState (value);
		}
		
		public function getState () :int {
			return collectionView.getState();
		}
		
		
		public function initHero (heroData:HeroData) :void {
			collectionView.initHero (heroData) 
		}
		
		public function initDeck (deckData:DeckData) :void {
			collectionView.initDeck (deckData);
		}
		
		
		public function getDeckItemsStack () :Sprite {
			return collectionView.getDeckItemsStack();
		}
		
		public function setDecksItemsCount (value:int) :void {
			collectionView.setDecksItemsCount(value);
		}
		
		public function getCardById (id:int):CollectionCard {
			return collectionView.getCardById (id);
		}
		
		public function setDust (value:int) :void {
			collectionView.setDust (value);
		}
		
		public function restateCards () :void {
			collectionView.restateCards();
		}
		
		
		/*
		
		public function addDeckItem (data:CollectionCardData) :void {
			collectionView.addDeckItem (data);
		}
		
		
		
		public function removeDeckItem (data:CollectionCardData) :void {
			collectionView.removeDeckItem (data);
		}
		
		public function getDeckItemsCount() :int {
			return collectionView.getDeckItemsCount();
		}
		
		public function getDeckItems () :Array {
			return collectionView.getDeckItems();
		}
		
		
		
		
		
		
		*/
		
	}

}