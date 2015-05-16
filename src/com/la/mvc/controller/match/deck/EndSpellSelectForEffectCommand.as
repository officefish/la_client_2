package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.service.MatchService;
	import com.la.mvc.view.deck.PlayerDeck;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EndSpellSelectForEffectCommand extends Command 
	{
		[Inject]
		public var event:DeckEvent;
		
		[Inject]
		public var service:MatchService; 
		
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel; 
		
		override public function execute():void 
		{
			model.drugMode = false;
			service.sendMessage('spell_to_target_for_effect', event.data); 
		}			
	}

}