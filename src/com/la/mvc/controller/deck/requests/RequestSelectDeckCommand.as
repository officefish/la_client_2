/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.controller.deck.requests {
import com.la.event.DeckServiceEvent;
import com.la.mvc.model.RootModel;
import com.la.mvc.service.DeckService;

import org.robotlegs.mvcs.Command;

public class RequestSelectDeckCommand extends Command {

    [Inject]
    public var service:DeckService;

    [Inject]
    public var event:DeckServiceEvent;
	
	[Inject (name='rootModel')]
    public var rootModel:RootModel; 


    override public function execute():void {
        service.select (rootModel.userId, event.getData().deck, event.getData().hero);
    }
}
}