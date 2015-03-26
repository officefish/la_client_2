package com.la.mvc.view.collection 
{
	import com.la.mvc.model.BookData;
	import com.la.mvc.model.CardData;
	import com.la.mvc.model.CollectionCardData;
	import com.la.mvc.view.card.CollectionCard;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftBook extends Book 
	{
		private var dust:int
		
		public function CraftBook (bookData:BookData, dust:int) :void {
			this.dust = dust;
			super (bookData);
		}
		
		override protected function getCards(items:Array):Array 
		{
			var card:CollectionCard; 
			var cardData:CollectionCardData;
			var _cards:Array = []
			
			for (var i:int = 0; i < items.length; i ++) {
				cardData = items[i] as CollectionCardData;
				if (cardData.isCraftAvailable()) {
				
					if (cardData.isGolden()) {
						cardData.setCount(cardData.getGoldenCount())
					} else {
						cardData.setCount(cardData.getSimpleCount())
					}
					
					if (cardData.getCount()) {
						trace (cardData.getTitle());
					}
					
					card = new CollectionCard (cardData);
					if (!cardData.getCount()) {
						card.setState (1);
						if (cardData.getBuyCost() > dust) {
							card.setState (0);
							card.block();	
						}
					} else {
						card.setState (0);
					}
										
					_cardsList[cardData.getId()] = card;
					_cards.push (card);
				}
				
			}
			return _cards;
		}	
		
		public function restateCards (dust:int) :void {
			var card:CollectionCard;
			var cardData:CollectionCardData;
			var cardPrice:int;
			for (var i:int = 0; i < cards.length; i ++) {
				card = cards[i];
				cardData = card.getCardData();
				if (cardData.isGolden()) {
					cardPrice = cardData.getBuyCost() * 2
				} else {
					cardPrice = cardData.getBuyCost();
				}
				if (cardPrice > dust) {
					card.setState (0);
					if (cardData.getCount() == 0) {
						card.block();
					} else {
						card.unblock();
					}
				} else {
					if (!cardData.getCount()) {
						card.setState(1);
						card.unblock();
					}
				}
			}
		}
	}

}