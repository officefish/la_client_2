/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.controller.deck {
<<<<<<< HEAD
import com.la.event.ApiServiceEvent;
import com.la.event.DeckEvent;
=======
import com.la.event.DeckServiceEvent;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import com.la.event.LobbyEvent;
import com.la.mvc.model.HeroModel;
import com.la.mvc.view.deck.DeckList;


import org.robotlegs.mvcs.Command;

public class DeckSelectCommand extends Command {

<<<<<<< HEAD
   
=======
    [Inject]
    public var event:DeckServiceEvent;

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    [Inject (name='heroModel')]
    public var heroModel:HeroModel;

    [Inject (name='deckList')]
    public var list:DeckList;

<<<<<<< HEAD
	[Inject]
	public var event:ApiServiceEvent;

    override public function execute():void {
        
		dispatch(new LobbyEvent(LobbyEvent.STARTUP_LOBBY));
=======


    override public function execute():void {
        dispatch(new LobbyEvent(LobbyEvent.STARTUP_LOBBY));
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

        heroModel.heroId = event.getData().hero_id;
        heroModel.deckId = event.getData().deck_id;
        heroModel.type = event.getData().hero_uid;
        heroModel.level = event.getData().level;
<<<<<<< HEAD
		
		if (contextView.contains(list)) contextView.removeChild(list);
		list.destroy ();
		
		dispatch (new DeckEvent (DeckEvent.CLOSE, null));

	}
=======

        list.close();


    }
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
}
}