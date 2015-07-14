package com.la.mvc.controller.deck.requests {
import com.la.mvc.model.RootModel;
import com.la.mvc.service.ApiService;
import com.la.mvc.service.DeckService;

import org.robotlegs.mvcs.Command;

public class RequestDeckListCommand extends Command {

    [Inject]
    public var service:ApiService;
	
	[Inject (name='rootModel')]
    public var rootModel:RootModel; 

    override public function execute():void {
        service.requestDeckList(rootModel.userId);
    }
}
}
		
