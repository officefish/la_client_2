package com.sla.mvc.model 
{
	import com.sla.mvc.model.data.DeckData;
	import com.sla.mvc.view.ability.AbilityCraftCard;
	import com.sla.mvc.view.card.CollectionCard;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionModel extends Actor 
	{
		private var _deckData:DeckData;
		private var _dust:int;
		private var _card:CollectionCard;
		private var _ablitity:AbilityCraftCard;
			
		public function set deckData (value:DeckData) :void {
			this._deckData = value; 
		}
		
		public function get deckData () :DeckData {
			return _deckData;
		}
		
		public function set dust (value:int) :void {
			_dust = value;
		}
		
		public function get dust () :int {
			return _dust;
		}
		
		public function set drawingCard (card:CollectionCard) :void {
			_card = card;
		}
		
		public function get drawingCard () :CollectionCard {
			return _card;
		}
		public function set drawingAbility (card:AbilityCraftCard) :void {
			_ablitity = card;
		}
		
		public function get drawingAbility () :AbilityCraftCard {
			return _ablitity;
		}
		
	}

}