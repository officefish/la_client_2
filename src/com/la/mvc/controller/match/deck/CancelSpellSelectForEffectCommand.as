package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.state.GameState;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CancelSpellSelectForEffectCommand extends Command 
	{
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		[Inject]
		public var event:DeckEvent; 
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel; 
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		override public function execute():void 
		{
			model.drugMode = true;
			
			var card:Card = model.drawingCard; 
			var mirror:Sprite = card.getMirror();
			mirror.visible = true;
			mirror.startDrag();
			
			mirror.x = event.data.mouseX - (mirror.width / 2);
			mirror.y = event.data.mouseY - (mirror.height / 2);
			
			contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove); 
			contextView.stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			contextView.stage.addEventListener(MouseEvent.CLICK, onMouseClick);
		}	
		
		private function onMouseMove (event:MouseEvent) :void {
			var playDistance:int = playerDeck.getPlayDistance();
			if (contextView.mouseY < playDistance) {
				destroyListeners();
				var card:Card = model.drawingCard; 
				var mirror:Sprite = card.getMirror();
				mirror.visible = false;
				dispatch (new SceneEvent (SceneEvent.SELECT_TARGET_FOR_EFFECT, { } ));
			}
		}
		
		private function onMouseClick (event:MouseEvent) :void {
			destroyListeners();
			skipDrawing();
		}
		
		private function onMouseUp (event:MouseEvent) :void {
			destroyListeners();
			skipDrawing();
		}
		
		private function skipDrawing () :void {
			rootModel.currentState = GameState.PLAYER_STEP; 
			dispatch(new DeckEvent (DeckEvent.SKIP_DRAWING, { } ));
		}
		
		private function destroyListeners () :void {
			contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove); 
			contextView.stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp);
			contextView.stage.removeEventListener(MouseEvent.CLICK, onMouseClick);
		}
	}

}