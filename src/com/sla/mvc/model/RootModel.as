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
		private var _userId:int;
		public function set lobbyId (value:int) :void {
			_lobbyId = value;
		}
		public function get lobbyId () :int {
			return _lobbyId;
		}	
		public function set userId (value:int) :void {
			_userId = value;
		}
		public function get userId () :int {
			return _userId;
		}	
		
		
	}

}