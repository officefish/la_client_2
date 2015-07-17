package com.sla.mvc.model 
{
	import org.robotlegs.mvcs.Actor;
	import com.sla.mvc.model.data.DeckData;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListModel extends Actor 
	{
		private var _list:Vector.<DeckData>;
		private var _isInit:Boolean = false;
		
		public function set list (decks:Vector.<DeckData>) :void {
			_list = decks;
			_isInit = true;
		}
		
		public function get list () :Vector.<DeckData> {
			return _list;
		}
		
		public function get isInit () :Boolean {
			return _isInit;
		}
		
		
		
		
	}

}