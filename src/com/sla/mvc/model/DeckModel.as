package com.sla.mvc.model 
{
	import com.sla.mvc.model.data.CardData;
	import org.robotlegs.mvcs.Actor;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckModel extends Actor
	{
		private var playerCards:Vector.<CardData>;
		private var opponentCards:Vector.<CardData>;
		//private var _drawingCard:Card;
		private var _dragMode:Boolean = false;
		private var _price:int = 0; 

		public function DeckModel() {
			
		}
		
		public function init () :void {
			playerCards = new Vector.<CardData>();
			opponentCards = new Vector.<CardData>();
		}
		
		public function clear () :void {
			playerCards = new Vector.<CardData>();
			opponentCards = new Vector.<CardData>();
		}

		public function addPlayerCards (vector:Vector.<CardData>) :void {
			playerCards = playerCards.concat(vector);
		}

		public function addOpponentCards (vector:Vector.<CardData>) :void {
			opponentCards = opponentCards.concat(vector);
		}

		public function getPlayerCards () :Vector.<CardData> {
			return playerCards.concat();
		}

		public function getOpponentCards () :Vector.<CardData> {
			return opponentCards;
		}

		public function clearPlayerCards () :void {
			playerCards = new Vector.<CardData>();
		}

		public function clearOpponentCards () :void {
			opponentCards = new Vector.<CardData>();
		}

		public function addPlayerCard (card:CardData) :void {
			playerCards.push(card);
		}

		public function addOpponentCard (card:CardData) :void{
			opponentCards.push(card);
		}
		
		private var _globalMirrorCardUp:Function;
		public function set onGlobalMirrorCardUp (value:Function) :void {
			_globalMirrorCardUp = value;
		}
		public function get onGlobalMirrorCardUp () :Function {
			return _globalMirrorCardUp;
		}
		
		private var _globalMouseMove:Function;
		public function set onGlobalMove (value:Function) :void {
			_globalMouseMove = value;
		}
		public function get onGlobalMove () :Function {
			return _globalMouseMove;
		}
		
		/*
		public function set drawingCard (value:Card) :void {
			_drawingCard = value;
		}
		public function get drawingCard () :Card {
			return _drawingCard;
		}
		*/
		
		public function set drugMode (value:Boolean) :void {
			_dragMode = value;
		}
		public function get drugMode () :Boolean {
			return _dragMode;
		}
		public function set price (value:int) :void {
			_price = value;
		}
		public function get price () :int {
			return _price;
		}		
	}

}