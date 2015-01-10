/**
 * Created by root on 10/24/14.
 */
package com.la.mvc.controller.state {
import com.la.event.DeckEvent;
import com.la.event.LobbyEvent;
import com.la.event.MatchEvent;
import com.la.mvc.model.RootModel;
<<<<<<< HEAD
import com.la.mvc.view.deck.DeckList;
import com.la.mvc.view.IIntro;
import com.la.state.GameState;
import flash.display.DisplayObject;
=======
import com.la.state.GameState;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import org.robotlegs.mvcs.Command;

public class ChangeStateCommand extends Command {

    [Inject (name='rootModel')]
    public var rootModel:RootModel;
<<<<<<< HEAD
		
    [Inject (name='deckList')]
    public var list:DeckList; 
	
	[Inject] 
    public var intro:IIntro;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2


    override public function execute():void {
        switch (rootModel.currentState) {
            case GameState.MATCH: {
                dispatch(new MatchEvent(MatchEvent.STARTUP_MATCH));
                break;
            }
            case GameState.LOBBY: {
                dispatch(new LobbyEvent(LobbyEvent.STARTUP_LOBBY_SERVICE));
                break;
            }
<<<<<<< HEAD
=======

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
            case GameState.DECK_LIST: {
                dispatch(new DeckEvent(DeckEvent.STARTUP_DECK_SERVICE, {}));
                break;
            }
<<<<<<< HEAD
			
			case GameState.CLOSE_MATCH_INTRO: {
				contextView.removeChild (list);
				intro.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
				contextView.addChild(intro as DisplayObject);
				break;
			}
=======

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
        }
    }


}
}