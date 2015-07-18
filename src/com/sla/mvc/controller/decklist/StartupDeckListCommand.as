package com.sla.mvc.controller.decklist {
	import com.sla.event.DeckListEvent;
	import com.sla.mvc.model.DeckListModel;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.mvc.view.decklist.DeckList;
	
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
				dispatch(new DeckListEvent(DeckListEvent.REQUEST_DECKLIST)); 
			}
		}		
	}

}