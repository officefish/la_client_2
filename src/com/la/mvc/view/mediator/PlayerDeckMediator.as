/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.ConsoleEvent;
import com.la.event.DeckEvent;
import com.la.event.ScenarioEvent;
import com.la.mvc.view.deck.PlayerDeck;

import org.robotlegs.mvcs.Mediator;
import com.demonsters.debugger.MonsterDebugger;

public class PlayerDeckMediator extends Mediator {

    [Inject (name='playerDeck')]
    public var playerDeck:PlayerDeck;

    override public function onRegister():void {
        eventMap.mapListener(playerDeck, DeckEvent.CARDS_ADDED, listener);
        eventMap.mapListener(playerDeck, DeckEvent.FIND_POSITION, listener);
        eventMap.mapListener(playerDeck, DeckEvent.STOP_FIND_POSITION, listener);
        eventMap.mapListener(playerDeck, DeckEvent.PLAYER_CARD_PLAY, listener);
		eventMap.mapListener(playerDeck, DeckEvent.SPELL_SELECT, listener);
		
		eventMap.mapListener(playerDeck, ConsoleEvent.DEBUG, debug);
		eventMap.mapListener(playerDeck, ScenarioEvent.ACTION, scenario);
    }
	
	private function listener (event:DeckEvent) :void {
        dispatch(event);
    }
	
	private function scenario (event:ScenarioEvent) :void {
		dispatch(event);
    }
	
	private function debug (event:ConsoleEvent) :void {
		
		dispatch (event);
	}

    override public function onRemove():void {
        super.onRemove()
    }
}
}