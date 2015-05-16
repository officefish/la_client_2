package com.la.mvc.view.mediator 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.card.CardSensor;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardSensorMediator extends Mediator 
	{
		
		[Inject]
		public var sensor:CardSensor;
		
		[Inject (name = 'deckModel')]
		public var model:DeckModel; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		
		override public function onRegister():void 
		{
			eventMap.mapListener(sensor, MouseEvent.MOUSE_OVER, onSensorOver);	
			eventMap.mapListener(sensor, MouseEvent.MOUSE_OUT, onSensorOut);
			eventMap.mapListener(sensor, MouseEvent.MOUSE_DOWN, onSensorDown);
			eventMap.mapListener(sensor, MouseEvent.MOUSE_UP, onSensorUp);
		}
		
		private function onSensorOver (event:MouseEvent) :void {
			
			if (model.drugMode) {
				return;
			}
			
			var card:Card = sensor.getCard (); 
			card.visible = false;
			
			model.drawingCard = card;
			
	        var mirror:Sprite = card.getMirror ();
			
			var position:Point = new Point (card.x, card.y);
			position = card.parent.localToGlobal (position);
			position.x += (card.width - mirror.width) / 2
			position.y -= (mirror.height - 40);
			
			mirror.x = position.x;
			mirror.y = position.y;
			
			playerDeck.addMirror(mirror);
		}
		
		private function onSensorOut (event:MouseEvent) :void {
			if (model.drugMode) {
				return;
			}
			
			model.drawingCard.visible = true;
			playerDeck.clearMirrorStack();
			dispatch(new DeckEvent (DeckEvent.GLOW_CARDS, {}))
		}
		private function onSensorDown (event:MouseEvent) :void {
			dispatch(new DeckEvent(DeckEvent.START_DRAWING, {})); 
		}
		private function onSensorUp (event:MouseEvent) :void {
			var card:Card = sensor.getCard (); 
			var mirror:Sprite = card.getMirror ();
			mirror.stopDrag();
			dispatch(new DeckEvent(DeckEvent.SKIP_DRAWING, {}));
		}
		
		
	}

}