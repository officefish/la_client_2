package com.sla.mvc.view.card 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardSensor extends Sprite 
	{
		
		private var _card:Card;
		
		public function CardSensor(card:Card) 
		{
			this._card = card;
			var quad:Quad = new Quad(Card.CARD_WIDTH - 10, Card.CARD_HEIGHT, 0xFF0000);
			quad.alpha = 0.01;
			quad.x -= Card.CARD_WIDTH / 2;
			quad.y -= Card.CARD_HEIGHT / 2;
			addChild(quad);
		}
		
		public function get card () :Card {
			return _card;
		}
		
	}

}