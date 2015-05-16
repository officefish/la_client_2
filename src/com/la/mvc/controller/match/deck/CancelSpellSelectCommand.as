package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.deck.PlayerDeck;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
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
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel; 
		
		override public function execute():void 
		{
			var card:Card = model.drawingCard;
			var mirror:Sprite = card.getMirror();
			mirror.visible = true;
			mirror.startDrag();
			
			mirror.x = event.data.mouseX - (mirror.width / 2);
			mirror.y = event.data.mouseY - (mirror.height / 2);
			contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, model.onGlobalMove); 
			contextView.stage.addEventListener (MouseEvent.MOUSE_UP, model.onGlobalMirrorCardUp);
			
			
		}
		
	}

}