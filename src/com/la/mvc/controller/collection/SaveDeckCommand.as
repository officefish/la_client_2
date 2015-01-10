package com.la.mvc.controller.collection 
{
	import com.la.event.CollectionEvent;
	import com.la.event.SceneEvent;
	import com.la.locale.Warning;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.service.ApiService;
	import com.la.mvc.view.collection.DeckItemSlot;
	import com.la.mvc.view.collection.ICollection;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SaveDeckCommand extends Command 
	{
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject]
		public var service:ApiService;  
		
		[Inject]
		public var event:CollectionEvent;
		
		[Inject (name='collection')]
		public var collection:ICollection;  
		
		[Inject (name='scene')]
		public var scene:IScene;   
				
		private var deckId:int;
		private var deckTitle:String;
		private var items:Array;
		
		override public function execute():void 
		{
			deckId = model.deckData.id
			deckTitle = event.getData().title;
			items = convertToList (collection.getDeckItems());
			
			contextView.addChild (scene as DisplayObject);
			scene.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
			
			if (collection.getDeckItemsCount() < 30) {
				collection.blur();
				scene.darken();
				scene.addEventListener (SceneEvent.WARNING_CONFIRM, onConfirm);
				scene.addEventListener (SceneEvent.WARNING_CANCEL, onCancel);
				scene.warning (Warning.DECK_NOT_COMPLICATED, true, true); 
			} else {
				service.saveDeck (1, deckId, deckTitle, items);
			}
			
		}
		
		private function onConfirm (event:SceneEvent) :void {
			scene.removeEventListener (SceneEvent.WARNING_CONFIRM, onConfirm);
			scene.removeEventListener (SceneEvent.WARNING_CANCEL, onCancel);
			scene.lighten(false);
			collection.stopBlur();
			service.saveDeck (1, deckId, deckTitle, items);
		}
		
		private function onCancel (event:SceneEvent) :void {
			scene.removeEventListener (SceneEvent.WARNING_CONFIRM, onConfirm);
			scene.removeEventListener (SceneEvent.WARNING_CANCEL, onCancel);
			scene.lighten(false);
			collection.stopBlur();
		}
		
		public function convertToList (items:Array) :Array {
			var deckItemData:Object;
			var slot:DeckItemSlot;
			var list:Array = []
			for (var i:int = 0; i < items.length; i++) {
				slot = items[i] as DeckItemSlot;
				deckItemData = { };
				deckItemData['id'] = slot.getCardData().getId();
				deckItemData['count'] = slot.getCount();
				deckItemData['golden'] = slot.getCardData().isGolden();
				list.push (deckItemData);
			}
			return list;
		}
	}

}