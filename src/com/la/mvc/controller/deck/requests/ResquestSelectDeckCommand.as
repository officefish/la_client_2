/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.controller.deck.requests {

import com.la.event.DeckEvent;
import com.la.mvc.model.RootModel;
import com.la.mvc.service.ApiService;
import org.robotlegs.mvcs.Command;

public class ResquestSelectDeckCommand extends Command {

    [Inject]
	public var service:ApiService; 
	
	[Inject]
	public var event:DeckEvent;
	
	[Inject (name='rootModel')]
    public var rootModel:RootModel; 
	
	override public function execute():void { 
        service.requestIntroSelectDeck (rootModel.userId, event.data.deckId, event.data.heroId);
    }
}
}