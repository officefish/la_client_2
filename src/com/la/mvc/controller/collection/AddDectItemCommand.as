package com.la.mvc.controller.collection 
{
	import com.la.event.CollectionEvent;
	import com.la.event.SceneEvent;
	import com.la.locale.Warning;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.view.card.CollectionCard;
	import com.la.mvc.view.collection.Collection;
	import com.la.mvc.view.collection.ICollection;
	import com.la.mvc.view.scene.IScene;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AddDectItemCommand extends Command 
	{
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel;
			
		[Inject (name='collection')]
		public var collection:ICollection; 
		
		[Inject]
		public var event:CollectionEvent;
		
		[Inject (name='scene')]
		public var scene:IScene;   
		
		override public function execute():void 
		{
			if (collection.getDeckItemsCount() < 30) {
				var card:CollectionCard = model.collectionCard as CollectionCard
				card.decrement();
				collection.addDeckItem (card.getCardData());
			} else {
				collection.blur();
				scene.darken();
				scene.addEventListener (SceneEvent.WARNING_CLOSE, onWarningClose);
				scene.warning (Warning.MAX_DECK_ITEMS_LIMIT);
			}
		}
		
		private function onWarningClose (event:SceneEvent) :void {
			scene.removeEventListener (SceneEvent.WARNING_CLOSE, onWarningClose);
			scene.lighten(false);
			collection.stopBlur();
		}
		
	}

}