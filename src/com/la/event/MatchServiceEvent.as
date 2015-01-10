/**
 * Created by root on 11/7/14.
 */
package com.la.event {
import flash.events.Event;

public class MatchServiceEvent extends Event {
    private var data:Object;

    public static const CONNECTION_INIT:String = 'connectionInit';
    public static const PREFLOP_INIT:String = 'preflopInit';
    public static const CHANGE_PREFLOP:String = 'changePreflop';
    public static const END_PREFLOP:String = 'endPreflop';
    public static const OPPONENT_PREFLOP_CLICK:String = 'opponentPreflopClick';
    public static const CHANGE_OPPONENT_PREFLOP:String = 'changeOpponentPreflop';
    public static const READY:String = 'ready';
    public static const OPPONENT_STEP:String = 'opponentStep';
<<<<<<< HEAD
	public static const PLAYER_STEP:String = 'player_step';
	public static const SCENARIO:String = 'scenario';
	public static const END_STEP_TIMER:String = 'endStepTimer';
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public function MatchServiceEvent(type:String,  data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        this.data = data;
        super(type, bubbles, cancelable)
    }

    public function getData () :Object {
        return data;
    }
    override public function clone():Event {
        return new MatchServiceEvent(type, data, bubbles, cancelable)
    }
}

}