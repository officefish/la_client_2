package com.la.mvc.controller.match.deck.drawing 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.state.GameState;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SkipDrawingCommand extends Command 
	{
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel; 
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
		
		
		override public function execute():void 
		{
			if (rootModel.currentState == GameState.PLAYER_STEP) {
				model.drugMode = false;
				model.drawingCard.visible = true;
				model.drawingCard.getMirror().visible = true;
				model.drawingCard.getMirror().stopDrag();
				model.block = false;
				playerDeck.clearMirrorStack();
				dispatch(new DeckEvent (DeckEvent.GLOW_CARDS, {}))
			}
			
		
		}		
	}

}