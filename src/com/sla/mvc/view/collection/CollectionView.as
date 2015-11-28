package com.sla.mvc.view.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.event.starling.StarlingCollectionEvent;
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
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.data.ListCollection;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import com.sla.event.starling.BookToolbarEvent;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import com.sla.mvc.view.collection.book.CraftBook;
	
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
		private var resetButton:Button;
		private var craftButton:Button;
		private var readyButton:Button;
		
		private var dust:int = 0;
		
		private var craftBar:CraftBar;
		
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
						
			newDeckButton = new Button();
			newDeckButton.styleNameList.add('collectionButton');
			newDeckButton.useHandCursor = true;
			newDeckButton.label = 'Create Deck';
			newDeckButton.addEventListener( Event.TRIGGERED, onNewDeck); 
			
			deckContainer = new DeckContainer(newDeckButton);
			deckContainer.x = 620;
			
			countBar = new CountBar ();
			countBar.x = this.width - countBar.width;
			countBar.y = this.height - countBar.height;
			countBar.addEventListener(StarlingCollectionEvent.SAVE, onSave);
			countBar.addEventListener(StarlingCollectionEvent.CLOSE, onClose);
						
			resetButton = new Button ();
			resetButton.label = 'Reset';
			resetButton.useHandCursor = true;
			resetButton.styleNameList.add('countBarButton');
			resetButton.x = 543;
			resetButton.y = 7;
			resetButton.addEventListener( Event.TRIGGERED, onReset); 
			
			craftButton = new Button ();
			craftButton.label = 'Craft';
			craftButton.useHandCursor = true;
			craftButton.styleNameList.add('countBarButton');
			craftButton.x = 543;
			craftButton.y = 7;
			craftButton.addEventListener( Event.TRIGGERED, onCraft); 
			
			readyButton = new Button ();
			readyButton.label = 'Ready';
			readyButton.useHandCursor = true;
			readyButton.styleNameList.add('countBarButton');
			readyButton.addEventListener( Event.TRIGGERED, onCraftReady); 
						
			craftBar = new CraftBar('Craft Cards', readyButton);
			craftBar.x = 620;
			//craftBar.getReadyButton().addEventListener (MouseEvent.CLICK, onCraftReadyClick);
			
			
			initPagesNavigation ();
		}
		
		private function onCraftReady (event:Event) :void {
			parent.dispatchEvent(new StarlingCollectionEvent(StarlingCollectionEvent.CRAFT_READY));
		}
		
		private function onCraft (event:Event) :void {
			parent.dispatchEvent(new StarlingCollectionEvent(StarlingCollectionEvent.CRAFT));
		}
		
		private function onNewDeck (event:Event) :void {
			parent.dispatchEvent(new StarlingCollectionEvent(StarlingCollectionEvent.NEW_DECK));
		}
		
		private function onClose (event:StarlingCollectionEvent) :void {
			parent.dispatchEvent(new StarlingCollectionEvent(StarlingCollectionEvent.CLOSE));
		}
		
		private function onSave (event:Event) :void {
			if (deckItemsContainer.slotsCount < 30) {
				activateAlertFilters();
				Alert.show( "This deck is not complete. Do you want to save it? ", "Warning", new ListCollection(
				[
					{ label: "Save", triggered: saveButton_triggeredHandler }, 
					{ label: "Cancel", triggered: cancelButton_triggeredHandler }
				]), null, true, true, slaAlertFactory );
			} else {
				saveDeck();
			}
			
		}
		
		private function activateAlertFilters () :void {
			var collection:Collection = this.parent as Collection;
			collection.blur();
			collection.darken();
		}
		
		private function deactivateAlertFilters () :void {
			var collection:Collection = this.parent as Collection;
			collection.stopBlur();
			collection.stopDarken();
		}
		
		private function saveButton_triggeredHandler (event:Event) :void {
			saveDeck();
			deactivateAlertFilters();
		}
		
		private function cancelButton_triggeredHandler (event:Event) :void {
			deactivateAlertFilters();
		}
		
		private function saveDeck() :void {
			var collection:ListCollection = deckItemsContainer.getCollection();
			var length:int = collection.length;
			var item:Object;
			var itemData:Object;
			var items:Array = [];
			for (var i:int = 0; i < length; i ++) {
				item = collection.getItemAt(i);
				itemData = { };
				itemData.count = item.count;
				if (item.golden != null) {
					itemData['golden'] = item.golden;
				} else {
					itemData['golden'] = false;
				}
				
				itemData.id = item.id;
				items.push(itemData);
			}
			parent.dispatchEvent (new StarlingCollectionEvent (StarlingCollectionEvent.SAVE, false,
				{
					'title':heroTitle.text,
					'items':items
				}
			));

		}
		
		private function onRemoveSlot (event:StarlingDeckListEvent) :void {
			parent.dispatchEvent (new StarlingDeckListEvent(StarlingDeckListEvent.REMOVE_SLOT, false, event.data));
		}
		
		private function onReset (event:Event) :void {
			
			var collection:ListCollection = deckItemsContainer.getCollection();
			var length:int = collection.length;
			var item:Object;
			var card:CollectionCard;
			for (var i:int = 0; i < length; i ++) {
				item = collection.getItemAt(i);
				card = getCardById(item.id);
				for (var j:int = 0; j < item.count; j++) {
					card.increment();
				}
			}
			deckItemsContainer.clear();
			countBar.setCount(deckItemsContainer.slotsCount);
		}
		
		private function slaAlertFactory():Alert
		{
			var alert:Alert = new Alert(); 
			alert.styleNameList.add( "sla-alert" );
			return alert;
		};
		
		public function setDust (value:int) :void {
			dust = value;
			craftBar.setDust (dust);
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
				contentSprite.addChild (craftButton);
				contentSprite.addChild (countBar);
				books = createBooks (booksData);

			} else if (state == EDIT) {
				countBar.setMode (1);
				countBar.setCount (0);
				contentSprite.addChild (deckItemsContainer);
				contentSprite.addChild (heroTitle);
				contentSprite.addChild (resetButton);
				contentSprite.addChild (countBar);
				books = createBooks (booksData);
			
			} else if (state == CRAFT) {
				contentSprite.addChild (craftBar);
				craftBar.setDust (dust);
				books = createCraftBooks (booksData);
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
		
		public function restateCards () :void {
			var book:CraftBook;
			for (var i:int = 0; i < books.length; i ++) {
				book = books[i];
				book.restateCards (dust);
			}
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
					data['golden'] = cardData.isGolden();
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
			

			countBar.setCount(deckData.items.length);
			deckItemsContainer.slotsCount = deckData.items.length;
			var array:Array = convertToArray(deckData.items);
			deckItemsContainer.initDataProvider(array);
			heroTitle.text = deckData.title;
			blockCardsUsedInDeck(array);
			
		}
		
		
	}

}