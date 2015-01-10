/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.FieldEvent;
import com.la.event.MatchEvent;
import com.la.event.ScenarioEvent;
import com.la.mvc.view.debug.Console;
import com.la.mvc.view.field.IField;

import org.robotlegs.mvcs.Mediator;

public class FieldMediator extends Mediator {

    [Inject (name='field')]
    public var field:IField;
	
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
    private function listener (event:FieldEvent) :void {
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}