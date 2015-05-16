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
	public class EndSpellSelectCommand extends Command 
	{
		[Inject]
		public var event:DeckEvent;
		
		[Inject]
		public var service:MatchService; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck;  
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel; 
		
		override public function execute():void 
		{
			event.data['cardIndex'] = playerDeck.getCardIndex(model.drawingCard);
			model.drugMode = false;
			service.sendMessage('play_card_spell_to_target', event.data);
		}		
	}

}