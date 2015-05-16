package com.la.mvc.controller.match.scenario.actions 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IToken;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.debug.Console;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DecreaseSpellCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console;  
		
		[Inject]
		public var event:SceneEvent; 
		
		[Inject (name = 'matchModel')]
		public var model:MatchModel;  
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		override public function execute():void 
		{
			var unit:IToken = event.data.targetToken as IToken;
			if (unit) {
				unit.deactivateSpellUp ();
			}
			if (event.data.playerSpellMixinFlag) {
				model.setSpellMixin(event.data.spellMixin);
				playerDeck.setSpellMixin(model.getSpellMixin());
			}
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));  
			
		}		
	}

}