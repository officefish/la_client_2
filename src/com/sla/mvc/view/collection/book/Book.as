package com.sla.mvc.view.collection.book 
{
	import com.sla.mvc.model.data.BookData;
	import com.sla.mvc.model.data.CollectionCardData;
	import com.sla.mvc.view.card.CollectionCard;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Book extends Sprite 
	{
		private var title:String;
		private var description:String;
		protected var cards:Array;
		private var pages:Array;
		private var actualPage:BookPage;
		
		protected var _cardsList:Object;
		
		public function Book(bookData:BookData) 
		{
			this.title = bookData.getTitle();
			this.description = bookData.getDescription();
			
			_cardsList = { };
			
			cards = getCards (bookData.getItems());
			
			var page:BookPage = new BookPage(title, description);
			page.y = 50;
			var card:CollectionCard;
			
			pages = [];
			pages.push(page);
			
			for (var i:int = 0; i < cards.length; i ++) {
				if (page.cardsCount == 8) {
					page = new BookPage(title, description);
					page.y = 50;
					pages.push(page);
				}
				card = cards[i];
				page.addCard(card);
			}
            actualPage = pages[0];
			
		}
		
		protected function getCards (items:Array) :Array {
			var card:CollectionCard;
			var cardData:CollectionCardData;
			var _cards:Array = []
			
			for (var i:int = 0; i < items.length; i ++) {
				cardData = items[i] as CollectionCardData;
				card = new CollectionCard (cardData);
				_cardsList[cardData.getId()] = card;
				_cards.push (card);
			}
			return _cards;
		}
		
		public function getCardsList () :Object {
			return _cardsList;
		}
		
		public function getActualPage () :BookPage {
			return actualPage;
		}
		
		public function getFirstPage () :BookPage {
			 actualPage = pages[0];
			 return actualPage;
		}
		
		public function getPage (index:int) :BookPage {
			if (pages[index]) {
				actualPage = pages[index];
			}
			return pages[index];
		}
		
		public function getLastPageIndex () :int {
			return pages.length - 1;
		}		
	}

}