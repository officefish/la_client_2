/**
 * Created by root on 11/2/14.
 */
package com.la.mvc.controller.deck {
<<<<<<< HEAD
import com.la.event.ApiServiceEvent;
=======
import com.la.event.DeckServiceEvent;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import com.la.mvc.view.deck.DeckList;

import org.robotlegs.mvcs.Command;

public class DeckListInitCommand extends Command {

    [Inject (name='deckList')]
    public var list:DeckList;

    [Inject]
<<<<<<< HEAD
    public var event:ApiServiceEvent;

    override public function execute():void {
        list.initDecks (event.getData()['decks'])
		list.activateDeck (event.getData()['actual_deck']);
=======
    public var event:DeckServiceEvent;

    override public function execute():void {
        list.setDeckListData(event.getData())
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }
}
}