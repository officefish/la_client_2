package com.la.mvc.controller.match.deck.drawing 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.model.CardType;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartDrawingCommand extends Command 
	{
		
		[Inject]
		public var event:DeckEvent;
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck;
		
		private var mirror:Sprite;
		private var card:Card;
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel;
		
		[Inject (name='field')]
		public var field:IField; 
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel;
		
			
		override public function execute():void 
		{
			if (model.block) {
				playerDeck.stopGlowCards();
				return;
			}
			
			if (rootModel.currentState != GameState.PLAYER_STEP) {
				playerDeck.stopGlowCards();
				return;
			}
			
			card = model.drawingCard;
			
			var price:int = model.price;
			var cardPrice:int = card.getPrice ();
			if (cardPrice > price) {
				playerDeck.stopGlowCards();
				return;
			}
			
			var numUnits:int = field.getUnitsNumChildren ();
			var opponentNumUnits:int = field.getUnitsNumChildren (false);
			
			if (card.getType() == CardType.UNIT && numUnits == 7) {
				playerDeck.stopGlowCards();
				return;
			}
			if (card.hasSeveralTargetsEptitude && opponentNumUnits < 2) {
				playerDeck.stopGlowCards();
				return;
			}
		
			
			mirror = card.getMirror() as Sprite;
			
			model.drugMode = true;
			
			playerDeck.stopGlowCards();
			model.block = true;
			
			mirror.startDrag ();
			
			model.onGlobalMirrorCardUp = onMirrorCardUp;
			model.onGlobalMove = onMouseMove;
			
			contextView.stage.addEventListener (MouseEvent.MOUSE_UP, onMirrorCardUp);
			
			if (card.getType() ==  CardType.SPELL_TO_TARGET) { 
				contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
			}
			if (card.getType() == CardType.UNIT) {
				dispatch(new DeckEvent(DeckEvent.FIND_POSITION, {}));
			}
		}
		
		private function onMirrorCardUp (event:MouseEvent) :void {
			var playDistance:int = playerDeck.getPlayDistance();
			
			mirror.stopDrag();
			if (card.getType() ==  CardType.SPELL_TO_TARGET) {
				destroyListeners ();
				dispatch (new DeckEvent(DeckEvent.SKIP_DRAWING, {} ));
				return;
			}
			if (card.getType() == CardType.UNIT) {
				dispatch (new DeckEvent(DeckEvent.STOP_FIND_POSITION, {}));
			}
		
			destroyListeners ();

			if (contextView.mouseY < playDistance) {
				
				model.drugMode = false;
				model.block = true;

				var cardIndex:int = playerDeck.getCardIndex(model.drawingCard);
				//var mirror:Sprite = model.drawingCard.getMirror();
				//mirror.visible = false;
				//playerDeck.destroyCard(model.drawingCard);
				dispatch (new DeckEvent(DeckEvent.PLAYER_CARD_PLAY, 
				{
					index:cardIndex,
					cardType:card.getType()
				}));
			} else {
				dispatch (new DeckEvent(DeckEvent.SKIP_DRAWING, {} ));
			}
			
		}
		
		private function onMouseMove (event:MouseEvent) :void {
			var playDistance:int = playerDeck.getPlayDistance();
			if (contextView.mouseY < playDistance) {
				destroyListeners();
				mirror.visible = false;
				dispatch (new DeckEvent (DeckEvent.SPELL_SELECT, {}))
			}
		}
		
		private function destroyListeners () :void {
			if (contextView.stage.hasEventListener(MouseEvent.MOUSE_MOVE)) {
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
			}
			contextView.stage.removeEventListener (MouseEvent.MOUSE_UP, onMirrorCardUp);

		}
	}

}