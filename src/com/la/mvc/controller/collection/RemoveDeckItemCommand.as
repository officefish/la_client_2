package com.la.mvc.controller.collection 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.view.card.CollectionCard;
	import com.la.mvc.view.collection.DeckItemSlot;
	import com.la.mvc.view.collection.ICollection;
	import com.la.mvc.view.scene.IScene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RemoveDeckItemCommand extends Command 
	{
		[Inject]
		public var event:CollectionEvent; 
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel;
			
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject (name='scene')] 
		public var scene:IScene;  
		
		override public function execute():void 
		{
			var cardCopy:CollectionCard = event.getData()['cardCopy'];
			var slot:DeckItemSlot = model.deckSlot;
			var card:CollectionCard = collection.getCardById (slot.getCardData().getId());
			
			card.increment();
			collection.removeDeckItem (slot.getCardData());
			
			// анимация в случае если открыта страница с картой 
			if (card.stage && cardCopy) {
				var position:Point = new Point(card.x, card.y); 
				position = card.parent.localToGlobal(position);
				scene.placeCard (cardCopy);
				TweenLite.to (cardCopy, 0.5, { x:position.x, y:position.y, ease:Expo.easeOut, onComplete:onComplete } );
			}
		}
		
		private function onComplete () :void {
			scene.endPlaceCard();
		}
	}

}