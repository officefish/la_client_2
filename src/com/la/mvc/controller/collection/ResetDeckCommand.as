package com.la.mvc.controller.collection 
{
	import com.la.mvc.view.card.CollectionCard;
	import com.la.mvc.view.collection.Collection;
	import com.la.mvc.view.collection.DeckItemSlot;
	import com.la.mvc.view.collection.ICollection;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ResetDeckCommand extends Command 
	{
			
		[Inject (name='collection')]
		public var collection:ICollection; 
				
		override public function execute():void 
		{
			var slots:Array = collection.getDeckItems();
			var slot:DeckItemSlot;
			var card:CollectionCard;
			for (var i:int = 0; i < slots.length; i ++) {
				slot = slots[i] as DeckItemSlot;
				while (slot.getCount()) {
					card = collection.getCardById (slot.getCardData().getId());
					card.increment();
					collection.removeDeckItem (slot.getCardData());
				}
			}
		}	
	}

}