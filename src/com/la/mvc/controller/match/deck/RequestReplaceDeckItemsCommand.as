package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.service.MatchService;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestReplaceDeckItemsCommand extends Command 
	{
		[Inject]
		public var event:DeckEvent;
		
		[Inject]
		public var service:MatchService; 

		
		override public function execute():void 
		{
			service.sendMessage('replace_deck_items', event.data);
		}		
	}

}