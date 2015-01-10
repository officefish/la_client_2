/**
 * Created by root on 11/4/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.DeckEvent;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.DeckList;
import com.la.state.GameState;
import org.robotlegs.mvcs.Mediator;

public class DeckListMediator extends Mediator {

    [Inject (name='deckList')]
    public var list:DeckList;

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
        dispatch(event);
    }

    override public function onRemove():void {
        super.onRemove()
    }
}
}