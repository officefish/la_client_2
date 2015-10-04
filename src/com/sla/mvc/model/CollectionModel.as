package com.sla.mvc.model 
{
	import com.sla.mvc.model.data.DeckData;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionModel extends Actor 
	{
		private var _deckData:DeckData;
			
		public function set deckData (value:DeckData) :void {
			this._deckData = value; 
		}
		
		public function get deckData () :DeckData {
			return _deckData;
		}
		
	}

}