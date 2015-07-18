package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.DeckListEvent;
	import com.sla.event.starling.DeckListItemEvent;
	import com.sla.event.starling.StarlingDeckListEvent;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingDeckListEvent.CLOSE, onClose);
			addViewListener(StarlingDeckListEvent.EDIT_DECK, onEditDeck);
			addViewListener(StarlingDeckListEvent.READY, onReady);
		}
		
		private function onClose (event:StarlingDeckListEvent) :void {
			dispatch(new DeckListEvent(DeckListEvent.CLOSE));
		}
		
		private function onEditDeck (event:StarlingDeckListEvent) :void {
			dispatch(new DeckListEvent(DeckListEvent.EDIT_DECK_FROM_DECKLIST, event.data));
		}
		
		private function onReady (event:StarlingDeckListEvent) :void {
			dispatch(new DeckListEvent(DeckListEvent.READY));
		}
	}

}