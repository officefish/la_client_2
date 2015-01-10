/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.controller.deck {

import com.la.event.ApiServiceEvent;
import com.la.event.DeckEvent;
import com.la.event.LobbyEvent;
import com.la.mvc.model.HeroModel;
import com.la.mvc.view.deck.DeckList;


import org.robotlegs.mvcs.Command;

public class DeckSelectCommand extends Command {

    [Inject (name='heroModel')]
    public var heroModel:HeroModel;

    [Inject (name='deckList')]
    public var list:DeckList;

	[Inject]
	public var event:ApiServiceEvent;

    override public function execute():void {

        heroModel.heroId = event.getData().hero_id;
        heroModel.deckId = event.getData().deck_id;
        heroModel.type = event.getData().hero_uid;
        heroModel.level = event.getData().level;
		
		if (contextView.contains(list)) contextView.removeChild(list);
		list.destroy ();
		
		dispatch (new DeckEvent (DeckEvent.CLOSE, null));

	}
}
}