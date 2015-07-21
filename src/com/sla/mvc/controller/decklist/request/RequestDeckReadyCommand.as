package com.sla.mvc.controller.decklist.request 
{
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.DeckListEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestDeckReadyCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:DeckListEvent;
		
		[Inject]
		public var service:ApiService;
		
		override public function execute():void 
		{
			MonsterDebugger.log("RequestDeckReadyCommand::execute()");
			super.execute();
			
			service.requestDeckReadyToLobby (event.data.deckId, event.data.heroId);
		}		
	}

}