package com.la.mvc.view.collection 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.hurlant.util.der.OID;
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.BookData;
	import com.la.mvc.model.CollectionCardData;
	import com.la.mvc.model.DeckData;
	import com.la.mvc.model.HeroData;
	import com.la.mvc.view.card.CollectionCard;
	import com.la.mvc.view.collection.ICollection;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Point;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Collection extends Sprite implements ICollection
	{
		private var collectionView:CollectionView;
		private var heroesView:HeroesView;
		
		private var stageWidth:int;
		private var stageHeight:int;
		
		
		public function Collection() 
		{
			collectionView = new CollectionView ();
			addChild (collectionView);
			
			heroesView = new HeroesView ();
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			collectionView.x = heroesView.x = (stageWidth - this.width) / 2;
			collectionView.y = heroesView.y = (stageHeight - this.height) / 2;
		}
		
		public function blur () :void {
			this.filters = [new BlurFilter(7,7,2)]
		}
		public function stopBlur () :void {
			this.filters = []
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
		
		public function initHero (heroData:HeroData) :void {
			collectionView.initHero (heroData) 
		}
		
		public function getDeckItemsStack () :Sprite {
			return collectionView.getDeckItemsStack();
		}
		
		public function addDeckItem (data:CollectionCardData) :void {
			collectionView.addDeckItem (data);
		}
		
		public function getCardById (id:int):CollectionCard {
			return collectionView.getCardById (id);
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
		
		public function initDeck (deckData:DeckData) :void {
			collectionView.initDeck (deckData);
		}



	}
}