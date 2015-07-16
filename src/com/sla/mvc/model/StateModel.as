package com.sla.mvc.model 
{
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StateModel extends Actor 
	{
		private var _state:GameState;
		
		public function set state (value:GameState) :void {
			_state = value;
		}
		public function get state () :GameState {
			return _state;
		}
	}

}