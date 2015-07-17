package com.sla.mvc.controller.deck 
{
	import com.sla.event.DeckEvent;
	import com.sla.mvc.model.DeckListModel;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.mvc.view.deck.DeckList;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartupDeckListCommand extends StarlingCommand 
	{
		[Inject]
		public var model:DeckListModel;
		
		[Inject]
		public var list:DeckList;
		
		override public function execute():void 
		{
			if (model.isInit) {
				contextView.addChild(list);
			} else {
				dispatch(new DeckEvent(DeckEvent.REQUEST_DECKLIST)); 
			}
			
		}		
	}

}