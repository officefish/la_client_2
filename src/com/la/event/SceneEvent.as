/**
 * Created by root on 10/25/14.
 */
package com.la.event {
import flash.events.Event;

public class SceneEvent extends Event {

    private var _data:Object;

    public static const CHANGE_PREFLOP:String = 'replacePreflop';
    public static const PREFLOP_INIT:String = 'preflopInit';
    public static const PREFLOP_COMPLETE:String = 'preflopComplete';
    public static const WELCOME_COMPLETE:String = 'welcomeAnimationComplete';
    public static const LIGHTEN_COMPLETE:String = 'lightenComplete';
	public static const WARNING_CLOSE:String = 'warningClose';
	public static const WARNING_CANCEL:String = 'warningCancel';
	public static const WARNING_CONFIRM:String = 'warningConfirm';
	
	public static const SELECT_FOR_EPTITUDE:String = 'selectForEptitude';
	public static const SELECT_FOR_EPTITUDE_INIT:String = 'selectForEptitudeInit';
	public static const CANCEL_SELECT_FOR_EPTITUDE_UNIT:String = 'cancelSelectForEptitudeUnit';
	public static const SCENARIO_END_SELECT_UNIT:String = 'scenarioEndSelectUnit';
	
	public static const PASSIVE_ATTACK:String = 'passiveAttack';
	
	public static const BACK_TOKEN_TO_HAND:String = 'backTokenToHand';


    public function SceneEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        this._data = data;
        super(type, bubbles, cancelable)
    }

    public function get data () :Object {
        return _data;
    }

    public function set data (value:Object) :void {
        _data = value;
    }

    override public function clone():Event {
        return new SceneEvent(type, data, bubbles, cancelable)
    }
}

}