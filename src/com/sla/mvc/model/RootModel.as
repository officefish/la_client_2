package com.sla.mvc.model 
{
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RootModel extends Actor 
	{
		private var _lobbyId:int;
		public function set lobbyId (value:int) :void {
			_lobbyId = value;
		}
		public function get lobbyId () :int {
			return _lobbyId;
		}		
		
	}

}