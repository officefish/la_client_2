/**
 * Created by root on 11/1/14.
 */
package com.la.mvc.controller.deck {
import com.la.mvc.model.RootModel;
import com.la.mvc.view.deck.DeckList;
import com.la.state.GameState;

import org.robotlegs.mvcs.Command;

public class StartupDeckListCommand extends Command {

    [Inject (name='deckList')]
    public var list:DeckList;

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

<<<<<<< HEAD
=======




>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    override public function execute():void {
        rootModel.currentState = GameState.DECK_LIST;

        list.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
        contextView.addChildAt(list, 0);
    }
}
}