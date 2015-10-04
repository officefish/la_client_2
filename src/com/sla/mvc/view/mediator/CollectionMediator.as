package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.event.starling.StarlingDeckListEvent;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionMediator extends StarlingMediator 
	{
		override public function onRegister():void 
		{
			addViewListener(StarlingDeckListEvent.REMOVE_SLOT, onRemoveSlot); 
		}
		
		private function onRemoveSlot (event:StarlingDeckListEvent) :void {
			dispatch(new CollectionEvent(CollectionEvent.REMOVE_FROM_DECK, { slotId:event.data.slotId } ));
		}
	}

}