/**
 * Created by root on 10/26/14.
 */
package com.la.event {
import flash.events.Event;

public class DeckEvent extends Event {

    public static const CARDS_ADDED:String = 'cardsAdded';
    public static const STARTUP_DECK_LIST:String = 'startupDeckList';
    public static const STARTUP_DECK_SERVICE:String = 'startupDeckService';
    public static const SELECT:String = 'deckListItemSelect';
    public static const CLOSE:String = 'deckClose';
    public static const PLAYER_CARD_ADDED:String = 'playerCardAdded';

    public static const FIND_POSITION:String = 'findPosition';
    public static const STOP_FIND_POSITION:String = 'stopFindPosition';

<<<<<<< HEAD
    public static const PLAYER_CARD_PLAY:String = 'player__CardPlay';
	public static const SELECT_DECK:String = 'selectDeck';
	public static const INTRO_EDIT_CLICK:String = 'introEditClick';
=======
    public static const PLAYER_CARD_PLAY:String = 'playerCardPlay';

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    private var _data:Object;

    public function DeckEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
<<<<<<< HEAD
        super(type, bubbles, cancelable);
		_data = data;
=======
        _data = data;
        super(type, bubbles, cancelable);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }

    public function get data () :Object {
        return _data;
    }

    override public function clone():Event {
        return new DeckEvent(type, data, bubbles, cancelable);
    }
}

}