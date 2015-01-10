package com.la.mvc.view.mediator 
{
	import com.la.event.CardEvent;
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.CollectionCardData;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.CollectionCard;
	import com.la.state.GameState;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	import org.robotlegs.mvcs.Mediator;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionCardMediator extends Mediator
	{
		[Inject]
		public var card:CollectionCard;
		
		[Inject (name='collectionModel')]
		public var model:CollectionModel;
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel;

		override public function onRegister():void {
			eventMap.mapListener(card, CardEvent.COLLECTION_CLICK, listener); 
			eventMap.mapListener(card, MouseEvent.MOUSE_OVER, onMouseOver);
			eventMap.mapListener(card, MouseEvent.MOUSE_OUT, onMouseOut);
			eventMap.mapListener(card, MouseEvent.MOUSE_DOWN, onMouseDown);
		}

		private function listener (event:CardEvent) :void {
			if (rootModel.currentState == GameState.COLLECTION) {
				model.collectionCard = card;
				dispatch(event);
			}
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			if (card.isBlocked()) {
				return;
			}
				
			
			if (rootModel.currentState == GameState.EDIT_DECK) {
				Mouse.cursor = MouseCursor.HAND; 
			}
		}
		private function onMouseOut (event:MouseEvent) :void {
			if (card.isBlocked()) {
				return;
			}
				
			
			if (rootModel.currentState == GameState.EDIT_DECK) {
				Mouse.cursor = MouseCursor.AUTO; 
			}
		}
		private function onMouseDown (event:MouseEvent) :void {
			if (rootModel.currentState == GameState.EDIT_DECK) {
				if (card.isBlocked()) {
					return;
				}
				model.collectionCard = card;
				dispatch(new CardEvent (CardEvent.DRAG_CARD, {'card':card}));
			}
		}
		
		override public function onRemove():void {
			super.onRemove()
		}		
	}

}