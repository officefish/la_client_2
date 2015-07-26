package com.sla.mvc.model 
{
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MatchModel extends Actor 
	{
		private var _matchId:int;
		
		public function set matchId (value:int) :void {
			_matchId = value;
		}

		public function get matchId () :int {
			return _matchId;
		}
		
	}

}