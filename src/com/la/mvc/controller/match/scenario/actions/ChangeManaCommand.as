package com.la.mvc.controller.match.scenario.actions 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ChangeManaCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject]
		public var event:SceneEvent;
			
		[Inject (name='field')]
		public var field:IField;
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel;
		
		override public function execute():void 
		{
			console.debug ('ChangeManaCommand::execute');
			
			var overload:int = event.data.overload;
			
			if (event.data.clientFlag) {
				if (event.data.attachment == 0) {
					model.price = int(event.data.price)
					field.setPlayerPrice (event.data.price, true, true, overload)
				} 
				if (event.data.attachment == 2) {
					model.price = int(event.data.playerPrice)
					field.setPlayerPrice (event.data.playerPrice, true, true, overload)
				}
				
			} else {
				if (event.data.attachment == 1) {
					field.setOpponentPrice (event.data.price, true, true) 
				}
				if (event.data.attachment == 2) {
					model.price = int(event.data.opponentPrice)
					field.setOpponentPrice (event.data.opponentPrice, true, true)
				}
			}
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION)); 
		}		
	}

}