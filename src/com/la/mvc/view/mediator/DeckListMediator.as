/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.DeckEvent;
<<<<<<< HEAD
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.DeckList;
import com.la.state.GameState;
=======
import com.la.event.DeckServiceEvent;
import com.la.mvc.view.deck.DeckList;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import org.robotlegs.mvcs.Mediator;

public class DeckListMediator extends Mediator {

    [Inject (name='deckList')]
    public var list:DeckList;
<<<<<<< HEAD
	
   [Inject (name='rootModel')]
    public var rootModel:RootModel;


    override public function onRegister():void {
        eventMap.mapListener(list, DeckEvent.SELECT_DECK, listener);
		eventMap.mapListener(list, DeckEvent.INTRO_EDIT_CLICK, listener);
        eventMap.mapListener(list, DeckEvent.CLOSE, close);
    }
    
	private function close (event:DeckEvent) :void {
        rootModel.currentState = GameState.CLOSE_MATCH_INTRO;
		dispatch(event);
    }
	
	private function listener (event:DeckEvent) :void {
=======

    override public function onRegister():void {
        eventMap.mapListener(list, DeckServiceEvent.RESPONSE_SELECT_DECK, listener);
        eventMap.mapListener(list, DeckEvent.CLOSE, close);
    }

    private function listener (event:DeckServiceEvent) :void {
        dispatch(event);
    }

    private function close (event:DeckEvent) :void {
        list.destroy ();
        if (contextView.contains(list)) contextView.removeChild(list);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}