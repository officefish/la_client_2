package com.sla.mvc.view.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.starling.StarlingDeckListEvent;
	import com.sla.mvc.model.data.BookData;
	import com.sla.mvc.model.data.CollectionCardData;
	import com.sla.mvc.model.data.DeckData;
	import com.sla.mvc.model.data.HeroData;
	import com.sla.mvc.view.card.CollectionCard;
	import com.sla.mvc.view.collection.book.Book;
	import com.sla.mvc.view.collection.book.BookToolbar;
	import com.sla.mvc.view.collection.deck.CountBar;
	import com.sla.mvc.view.collection.deck.DeckContainer;
	import com.sla.mvc.view.collection.deck.DeckItemsContainer;
	import com.sla.mvc.view.collection.deck.HeroTitle;
	import feathers.controls.Button;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import com.sla.event.starling.BookToolbarEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionView extends Sprite 
	{
		private var cards:Object;
		private var books:Array;
		
		private var bg:Quad;
		private var contentSprite:Sprite;
		private var bookStack:Sprite;
		
		public static const INTRO:int = 0;
		public static const EDIT:int = 1;
		public static const CRAFT:int = 2;
		
		private var toolbar:BookToolbar;
		
		private var state:int;
		
		private var pageIndex:int;
		private var bookIndex:int;
		
		private var leftSencor:Sprite;
		private var rightSencor:Sprite;
		
		private var deckContainer:DeckContainer;
		private var newDeckButton:Button;
		private var deckItemsContainer:DeckItemsContainer;
		
		private var countBar:CountBar;
		
		private var heroTitle:HeroTitle;
		
		public function CollectionView() 
		{
			bg = new Quad(800, 600, 0xCCCCCC);
			addChild(bg);
			
			contentSprite = new Sprite();
			addChild(contentSprite);
			
			bookStack = new Sprite();
			
			deckItemsContainer = new DeckItemsContainer();
			deckItemsContainer.addEventListener(StarlingDeckListEvent.REMOVE_SLOT, onRemoveSlot);
			deckItemsContainer.y = 50;
			deckItemsContainer.x = 620;
			
			heroTitle = new HeroTitle();
			heroTitle.x = 620;
			
			
			//newDeckButton = new NewDeckButton ();
			//newDeckButton.addEventListener (MouseEvent.CLICK, onNewDeck);
			
			newDeckButton = new Button();
			newDeckButton.styleNameList.add('collectionButton');
			newDeckButton.useHandCursor = true;
			newDeckButton.label = 'Create Deck';
			
			deckContainer = new DeckContainer(newDeckButton);
			deckContainer.x = 620;
			
			countBar = new CountBar ();
			countBar.x = this.width - countBar.width;
			countBar.y = this.height - countBar.height;
			
			//booksStack = new Sprite ();
			
			initPagesNavigation ();
		}
		
		private function onRemoveSlot (event:StarlingDeckListEvent) :void {
			dispatchEvent (new StarlingDeckListEvent(StarlingDeckListEvent.REMOVE_SLOT, false, event.data));
		}
		
		private function initPagesNavigation () :void {
			
			CollectionCursor.init();
			
			leftSencor = new Sprite();
			leftSencor.addChild(new Quad(40, 550, 0x444444));
			leftSencor.alpha = 0.01;
			leftSencor.y = 50;
			leftSencor.addEventListener (TouchEvent.TOUCH, onLeftClick);
			
			rightSencor = new Sprite();
			rightSencor.addChild(new Quad(60, 550, 0x444444));
			rightSencor.y = 50;
			rightSencor.alpha = 0.01;
			rightSencor.x = 560;
			rightSencor.addEventListener (TouchEvent.TOUCH, onRightClick);
			

		}
		
		private function onLeftClick (event:TouchEvent) :void {
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER)) {
				CollectionCursor.setState (CollectionCursor.LEFT);
			} else {
				CollectionCursor.setState (CollectionCursor.DEFAULT);
			}
			if (event.getTouch(this, TouchPhase.BEGAN)) 
			{
				CollectionCursor.setState (CollectionCursor.LEFT);
				previous();  
			}
		}
		
		private function onRightClick (event:TouchEvent) :void {
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER)) {
				CollectionCursor.setState (CollectionCursor.RIGHT);
			} else {
				CollectionCursor.setState (CollectionCursor.DEFAULT);
			}
			if (event.getTouch(this, TouchPhase.BEGAN)) 
			{
				CollectionCursor.setState (CollectionCursor.RIGHT);
				next();
			}
		}
		
		public function setState (value:int) :void {
			this.state = value;
		}
		
		public function getState () :int {
			return state;
		}
		
		
		public function initBooks (booksData:Array) :void {
			contentSprite.removeChildren();
			bookStack.removeChildren();
			
			
			
			if (toolbar) {
				toolbar.removeEventListener (BookToolbarEvent.CLICK, onToolbarClick)
				toolbar.destroy();
			}
			
			contentSprite.addChild(bookStack);			
			contentSprite.addChild (leftSencor);
			contentSprite.addChild (rightSencor);
						
			cards = {};
			
			
			if (state == INTRO) {
				contentSprite.addChild (deckContainer);
				countBar.setMode (0);
				//addChild (createCardsButton);
				contentSprite.addChild (countBar);
				books = createBooks (booksData);

			} else if (state == EDIT) {
				countBar.setMode (1);
				countBar.setCount (0);
				contentSprite.addChild (deckItemsContainer);
				contentSprite.addChild (heroTitle);
				//addChild (resetButton);
				contentSprite.addChild (countBar);
				books = createBooks (booksData);
			
			} else if (state == CRAFT) {
				//addChild (craftWidget);
				//craftWidget.setDust (dust);
				//books = createCraftBooks (booksData);
			}
						
			toolbar = new BookToolbar (booksData.length);
			toolbar.y = 10;
			toolbar.x = 20; 
			toolbar.addEventListener (BookToolbarEvent.CLICK, onToolbarClick)
			contentSprite.addChild (toolbar);
			toolbar.activate (0);
			
			if (books[1]) {
				var book:Book = books[0] as Book;
				bookStack.addChild (book.getActualPage());
			}
			
			pageIndex = 0;
			bookIndex = 0;
			
		}
		
		public function getDeckItemsStack () :Sprite {
			return deckItemsContainer;
		}
		
		private function onToolbarClick (event:BookToolbarEvent) :void {
			while (bookStack.numChildren) bookStack.removeChildAt (0);
			var index:int = event.data.index;
			var book:Book = books[index] as Book;
			bookStack.addChild (book.getFirstPage());
			toolbar.activate (index);
			
			pageIndex = 0;
			bookIndex = index;

		}
		
		private function createBooks (booksData:Array) :Array {
			var books:Array = [];
			var bookData:BookData; 
			var book:Book;
			var bookCards:Object;
			
			for (var i:int = 0; i < booksData.length; i ++) {
				bookData = booksData[i] as BookData;
				book = new Book (bookData); 
				bookCards = book.getCardsList();
				addCards (cards, bookCards);
				books.push(book);
			}
			
			return books;
		}
		
		private function addCards (list:Object, cardsList:Object) :void {
			for (var prop:* in cardsList) {
				list[prop] = cardsList[prop];
			}
		}
		
		private function next () :void {
			var book:Book = books[bookIndex] as Book;
			pageIndex ++;
			var nextPage:Sprite = book.getPage(pageIndex) as Sprite; 
			if (nextPage) {
				while (bookStack.numChildren) bookStack.removeChildAt (0);
				bookStack.addChild (nextPage);
			} else {
				bookIndex ++; 
				if (bookIndex == books.length) {
					pageIndex --;
					bookIndex --;
					return;
				} else {
					pageIndex = 0;
					while (bookStack.numChildren) bookStack.removeChildAt (0);
					toolbar.activate (bookIndex);
					book = books[bookIndex] as Book;
					bookStack.addChild (book.getFirstPage());
				}
			}
		}
		
		private function previous () :void {
			var previousPage:Sprite
			var book:Book = books[bookIndex] as Book;
			pageIndex --;
			if (pageIndex > -1) {
				previousPage = book.getPage(pageIndex) as Sprite; 
				while (bookStack.numChildren) bookStack.removeChildAt (0);
				bookStack.addChild (previousPage);
			} else {
				bookIndex --; 
				if (bookIndex <= - 1) {
					pageIndex ++;
					bookIndex ++;
					return;
				} else {
					while (bookStack.numChildren) bookStack.removeChildAt (0);
					toolbar.activate (bookIndex);
					book = books[bookIndex] as Book;
					pageIndex = book.getLastPageIndex();
					previousPage = book.getPage (pageIndex)
					bookStack.addChild (previousPage);
				}
			}
		}
		
		public function initDecks (decks:Array) :void {
			countBar.setCount (decks.length);
			deckContainer.clear();
			var deckData:DeckData;
			for (var i:int = 0; i < decks.length; i ++) {
				deckData = decks[i];
				deckContainer.addDeck (deckData);
			}
		}
		
		public function initHero (heroData:HeroData) :void { 
			heroTitle.setHero (heroData); 
		}
		
		public function convertToArray(v:Vector.<CollectionCardData>) :Array {
			var a:Array = [] 
			var cardData:CollectionCardData;
			var deckCards:Object = {}
			var data:Object;
			for (var i:int = 0; i < v.length; i ++) {
				cardData =  v[i] as CollectionCardData;
				if (deckCards[cardData.id] == 	null) {
					data = { }
					data['title'] = cardData.title;
					data['price'] = cardData.price;
					data['count'] = 1
					data['id'] = cardData.id;
					a.push(data);
					deckCards[cardData.id] = data;
				} else {
					deckCards[cardData.id].count ++;  
				}
			}
			return a;
		}
		
		public function getCardById (id:int):CollectionCard {
			return cards[id]; 
		}
		
		public function blockCardsUsedInDeck (array:Array) :void {
			var length:int = array.length;
			var data:Object;
			var card:CollectionCard;
			for (var i:int = 0; i < array.length; i ++) {
				data = array[i];
				card = getCardById(data.id);
				for (var j:int = 0; j < data.count; j ++) {
					card.decrement();
				}
				
				
			}
		}
		
		public function setDecksItemsCount (value:int) :void {
			countBar.setCount(value);
		}
		
		public function initDeck (deckData:DeckData) :void {
			MonsterDebugger.log ('initDeck');
			//deckItemsContainer.defaultStack();
			countBar.setCount(deckData.items.length);
			deckItemsContainer.slotsCount = deckData.items.length;
			var array:Array = convertToArray(deckData.items);
			//MonsterDebugger.log (array);
			deckItemsContainer.initDataProvider(array);
			heroTitle.text = deckData.title;
			blockCardsUsedInDeck(array);
			/*
			this.deckId = deckData.id;
			heroTitle.setTitle (deckData.title);
			
			if (deckData.items) {
				var cardData:CollectionCardData;
				var card:CollectionCard;
				for (var i:int = 0; i < deckData.items.length; i ++) {
					cardData = deckData.items[i] as CollectionCardData;
					deckItemsContainer.addDeckItem (cardData);
					countBar.setCount (deckItemsContainer.getCount());
					card = getCardById (cardData.getId())
					
					try 
					{ 
						// some code that could throw an error 
						card.decrement();
					} 
					catch (err:Error) 
					{ 
						trace ('problem with card:' + cardData.getTitle() + ', (id:' + cardData.getId()+')');
						// code to react to the error 
					} 
					
				}
			}
			*/
		}
		
		
	}

}