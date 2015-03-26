package com.la.mvc.view.collection 
{
	import com.la.mvc.model.CollectionCardData;
	import com.la.mvc.model.DeckData;
	import com.la.mvc.model.HeroData;
	import com.la.mvc.view.ui.SmallButton;
	import flash.display.Sprite;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.hurlant.util.der.OID;
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.BookData;
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
	public class CollectionView extends Sprite 
	{
		public static const INTRO:int = 0;
		public static const EDIT:int = 1;
		public static const CRAFT:int = 2;
		
		private var books:Array;
		private var decksContainer:DecksContainer;
		private var toolbar:BooksToolbar;
		private var booksStack:Sprite;
		
		private var leftSencor:Sprite;
		private var rightSencor:Sprite;
		
		private var pageIndex:int;
		private var bookIndex:int;
		
		private var closeButton:Sprite;
		private var saveDeckButton:Sprite;
		
		private var newDeckButton:NewDeckButton;
		
		private var state:int = 0;
		
		private var heroTitle:HeroTitle;
		private var deckItemsContainer:DeckItemsContainer;
		
		private var cards:Object;
		
		private var countBar:CountBar;
		private var resetButton:CountBarButton;
		
		private var deckId:int;
		
		private var createCardsButton:SmallButton;
		
		private var craftWidget:CraftBar;
		
		private var dust:int;

				
		public function CollectionView() 
		{
			books = [];
			cards = {};
			
			graphics.beginFill(0xCCCCCC, 1);
			graphics.drawRect(0,0,800,600);
			graphics.endFill();
			
			newDeckButton = new NewDeckButton ();
			newDeckButton.addEventListener (MouseEvent.CLICK, onNewDeck);
			
			decksContainer = new DecksContainer(newDeckButton);
			decksContainer.x = 620;
			
			booksStack = new Sprite ();
			
			initPagesNavigation ();
			
			countBar = new CountBar ();
			countBar.x = this.width - countBar.width;
			countBar.y = this.height - countBar.height;
			
			closeButton = countBar.getCloseButton();
			closeButton.addEventListener (MouseEvent.CLICK, onClose);
			
			saveDeckButton = countBar.getSaveButton();
			saveDeckButton.addEventListener (MouseEvent.CLICK, onSaveDeck);
			
			resetButton = new CountBarButton ('Сбросить');
			resetButton.x = 543;
			resetButton.y = 7;
			resetButton.addEventListener (MouseEvent.CLICK, onResetClick);
			
			createCardsButton = new SmallButton('Создание карт', 100, 35);
			createCardsButton.addEventListener (MouseEvent.CLICK, onCreateCardsClick);
			createCardsButton.x = 513;
			createCardsButton.y = 7;
						
			heroTitle = new HeroTitle();
			heroTitle.x = 620;
			deckItemsContainer = new DeckItemsContainer ();
			deckItemsContainer.x = 620;
			deckItemsContainer.y = heroTitle.height;
			
			craftWidget = new CraftBar ();
			craftWidget.x = 620;
			craftWidget.getReadyButton().addEventListener (MouseEvent.CLICK, onCraftReadyClick);
			
		
		}
		
		public function getDeckItemsStack () :Sprite {
			return deckItemsContainer;
		}

		
		public function initHero (heroData:HeroData) :void {
			heroTitle.setHero (heroData);
		}
		
		private function onCraftReadyClick (event:MouseEvent) :void {
			parent.dispatchEvent (new CollectionEvent (CollectionEvent.CRAFT_READY));
		}
		
		private function onResetClick (event:MouseEvent) :void {
			deckItemsContainer.defaultStack();
			parent.dispatchEvent (new CollectionEvent (CollectionEvent.RESET_DECK));
		}
		
		private function onCreateCardsClick (event:MouseEvent) :void {
			parent.dispatchEvent (new CollectionEvent (CollectionEvent.CREATE_CARDS));
		}
		
		private function onClose(event:MouseEvent) :void {
			parent.dispatchEvent (new CollectionEvent (CollectionEvent.CLOSE));
		}
		
		private function onSaveDeck(event:MouseEvent) :void {
			parent.dispatchEvent (new CollectionEvent (CollectionEvent.SAVE_DECK, {'title':heroTitle.getTitle()}));
		}
		
		private function onNewDeck (event:MouseEvent) :void {
			deckItemsContainer.clear();
			deckItemsContainer.defaultStack();
			parent.dispatchEvent (new CollectionEvent (CollectionEvent.NEW_DECK));
		}
		
		public function initDeck (deckData:DeckData) :void {
			deckItemsContainer.clear();
			deckItemsContainer.defaultStack();
			
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
		}
			
		public function initBooks (booksData:Array) :void {
			while (this.numChildren) removeChildAt (0);
			while (booksStack.numChildren) booksStack.removeChildAt(0);
			
			if (toolbar) {
				toolbar.removeEventListener (ToolbarButtonEvent.CLICK, onToolbarClick)
				toolbar.destroy();
			}
			
			
			addChild (booksStack);
			addChild (leftSencor);
			addChild (rightSencor);
						
			cards = {};
			
			if (state == INTRO) {
				addChild (decksContainer);
				countBar.setMode (0);
				addChild (createCardsButton);
				addChild (countBar);
				books = createBooks (booksData);

			} else if (state == EDIT) {
				countBar.setMode (1);
				countBar.setCount (0);
				addChild (deckItemsContainer);
				addChild (heroTitle);
				addChild (resetButton);
				addChild (countBar);
				books = createBooks (booksData);
			
			} else if (state == CRAFT) {
				addChild (craftWidget);
				craftWidget.setDust (dust);
				books = createCraftBooks (booksData);
			}
			
			
			
			
			
			
			
			toolbar = new BooksToolbar (booksData.length);
			toolbar.y = 10;
			toolbar.x = 20;
			toolbar.addEventListener (ToolbarButtonEvent.CLICK, onToolbarClick)
			addChild (toolbar);
			toolbar.activate (0);
			
			if (books[1]) {
				var book:Book = books[0] as Book;
				booksStack.addChild (book.getActualPage());
			}
			
			pageIndex = 0;
			bookIndex = 0;
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
		
		public function setDust (value:int) :void {
			dust = value;
			craftWidget.setDust (dust);
		}
		
		
		private function createCraftBooks (booksData:Array) :Array {
		var books:Array = [];
			var bookData:BookData;
			var book:Book;
			var bookCards:Object;
			for (var i:int = 0; i < booksData.length; i ++) {
				bookData = booksData[i] as BookData;
				book = new CraftBook (bookData, dust);
				bookCards = book.getCardsList();
				addCards (cards, bookCards);
				books.push(book);
			}
			return books;
		}
		
		public function restateCards () :void {
			var book:CraftBook;
			for (var i:int = 0; i < books.length; i ++) {
				book = books[i];
				book.restateCards (dust);
			}
		}
		
		private function addCards (list:Object, cardsList:Object) :void {
			for (var prop:* in cardsList) {
				list[prop] = cardsList[prop];
			}
		}
		
		public function getCardById (id:int):CollectionCard {
			return cards[id]; 
		}
		
		private function onToolbarClick (event:ToolbarButtonEvent) :void {
			while (booksStack.numChildren) booksStack.removeChildAt (0);
			var index:int = event.getIndex();
			var book:Book = books[index] as Book;
			booksStack.addChild (book.getFirstPage());
			toolbar.activate (index);
			
			pageIndex = 0;
			bookIndex = index;

		}
		
		private function next () :void {
			var book:Book = books[bookIndex] as Book;
			pageIndex ++;
			var nextPage:Sprite = book.getPage(pageIndex) as Sprite; 
			if (nextPage) {
				while (booksStack.numChildren) booksStack.removeChildAt (0);
				booksStack.addChild (nextPage);
			} else {
				bookIndex ++; 
				if (bookIndex == books.length) {
					pageIndex --;
					bookIndex --;
					return;
				} else {
					pageIndex = 0;
					while (booksStack.numChildren) booksStack.removeChildAt (0);
					toolbar.activate (bookIndex);
					book = books[bookIndex] as Book;
					booksStack.addChild (book.getFirstPage());
				}
			}
		}
		
		private function previous () :void {
			var previousPage:Sprite
			var book:Book = books[bookIndex] as Book;
			pageIndex --;
			if (pageIndex > -1) {
				previousPage = book.getPage(pageIndex) as Sprite; 
				while (booksStack.numChildren) booksStack.removeChildAt (0);
				booksStack.addChild (previousPage);
			} else {
				bookIndex --; 
				if (bookIndex <= - 1) {
					pageIndex ++;
					bookIndex ++;
					return;
				} else {
					while (booksStack.numChildren) booksStack.removeChildAt (0);
					toolbar.activate (bookIndex);
					book = books[bookIndex] as Book;
					pageIndex = book.getLastPageIndex();
					previousPage = book.getPage (pageIndex)
					booksStack.addChild (previousPage);
				}
			}
		}
		
		private function initPagesNavigation () :void {
			
			CollectionCursor.init();
			
			leftSencor = new Sprite();
			leftSencor.graphics.beginFill (0xCCCCCC, 0.01);
			leftSencor.graphics.drawRect (0, 0, 30, 550);
			leftSencor.graphics.endFill();
			leftSencor.y = 50;
			
			
			leftSencor.addEventListener (MouseEvent.MOUSE_OVER, onLeftMouseOver);
			leftSencor.addEventListener (MouseEvent.MOUSE_OUT, onNavOut);
			leftSencor.addEventListener (MouseEvent.CLICK, onLeftClick);
			
			rightSencor = new Sprite();
			rightSencor.graphics.beginFill (0xCCCCC, 0.01);
			rightSencor.graphics.drawRect (0, 0, 60, 550);
			rightSencor.graphics.endFill();
			rightSencor.y = 50;
			rightSencor.x = 560;
			
			
			rightSencor.addEventListener (MouseEvent.MOUSE_OVER, onRightMouseOver);
			rightSencor.addEventListener (MouseEvent.MOUSE_OUT, onNavOut);
			rightSencor.addEventListener (MouseEvent.CLICK, onRightClick);
			

		}
		
		private function onLeftMouseOver (event:MouseEvent) :void {
			CollectionCursor.setState (CollectionCursor.LEFT);
		}
		
		private function onRightMouseOver (event:MouseEvent) :void {
			CollectionCursor.setState (CollectionCursor.RIGHT);
		}
		
		private function onLeftClick (event:MouseEvent) :void {
			previous ();
		}
		
		private function onRightClick (event:MouseEvent) :void {
			next ();
		}
		
		private function onNavOut (event:MouseEvent) :void {
			CollectionCursor.setState (CollectionCursor.DEFAULT);
		}
		
		public function setState (value:int) :void {
			this.state = value;
		}
		
		public function getState () :int {
			return state;
		}
		
		public function addDeckItem (data:CollectionCardData) :void {
			deckItemsContainer.addDeckItem (data);
			countBar.setCount (deckItemsContainer.getCount());
		}
		
		public function removeDeckItem (data:CollectionCardData) :void {
			deckItemsContainer.removeDeckItem (data);
			countBar.setCount (deckItemsContainer.getCount());
		}
		
		public function getDeckItemsCount() :int {
			return deckItemsContainer.getCount();
		}
		
		public function getDeckItems () :Array {
			return deckItemsContainer.getDeckItems();

		}
		
		public function initDecks (decks:Array) :void {
			countBar.setCount (decks.length);
			decksContainer.clear();
			var deckData:DeckData;
			for (var i:int = 0; i < decks.length; i ++) {
				deckData = decks[i];
				decksContainer.addDeck (deckData);
			}
		}
	}
}
