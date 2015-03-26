package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.view.deck.PlayerDeck;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CancelSpellSelectCommand extends Command 
	{
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		[Inject]
		public var event:DeckEvent; 
		
		override public function execute():void 
		{
			playerDeck.cancelSpellSelect(event.data.mouseX, event.data.mouseY);
		}
		
	}

}