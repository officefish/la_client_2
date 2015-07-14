/**
 * Created by root on 10/24/14.
 */
package com.la.event {
import flash.events.Event;

public class FieldEvent extends Event {

    public static const WELCOME_COMPLETE:String = 'welcomeAnimationComplete';
	public static const END_STEP:String = 'endStep';
	public static const ACHIEVE_PREVIEW:String = 'fieldAchievePreview';
	public static const ACTIVATE_SPELL_ACHIEVE:String = 'activateSpellAchieve';
	public static const ACTIVATE_SPELL_TO_TARGET_ACHIEVE:String = 'activateSpellToTargetAchieve';
	public static const ACHIEVE_TARGET_INIT:String = 'initAchieveTarget';
	
	
	
	private var _data:Object;

    public function FieldEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
        this._data = data;
		super(type, bubbles, cancelable)
    }
	
	public function getData () :Object {
		return _data;
	}

    override public function clone():Event {
        return new FieldEvent(type, _data, bubbles, cancelable)
    }
}

}