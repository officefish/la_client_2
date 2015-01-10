/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.intro {
import com.la.event.DeckEvent;
import com.la.event.LobbyEvent;


import org.robotlegs.mvcs.Command;

public class SelectGameCommand extends Command {

    override public function execute():void {
        dispatch(new DeckEvent(DeckEvent.STARTUP_DECK_LIST, {}));
<<<<<<< HEAD
=======
        //dispatch(new MatchEvent(MatchEvent.STARTUP_MATCH));
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }
}
}