/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.FieldEvent;
import com.la.event.MatchEvent;
<<<<<<< HEAD
import com.la.event.ScenarioEvent;
import com.la.mvc.view.debug.Console;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import com.la.mvc.view.field.IField;

import org.robotlegs.mvcs.Mediator;

public class FieldMediator extends Mediator {

    [Inject (name='field')]
    public var field:IField;
<<<<<<< HEAD
	
	[Inject (name='appConsole')]
	public var console:Console;  

    override public function onRegister():void {
        //eventMap.mapListener(field, FieldEvent.WELCOME_COMPLETE, listener);
		eventMap.mapListener(field, ScenarioEvent.ACTION, scenario);
    }
	
	private function endStep (event:FieldEvent) :void {
		dispatch (event);
	}
	
	private function scenario (event:ScenarioEvent) :void {
		dispatch (new ScenarioEvent (ScenarioEvent.ACTION));		
	}
=======

    override public function onRegister():void {
        //eventMap.mapListener(field, FieldEvent.WELCOME_COMPLETE, listener);
    }
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    private function listener (event:FieldEvent) :void {
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}