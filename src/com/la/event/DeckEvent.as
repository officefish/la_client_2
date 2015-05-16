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
    public static const PLAYER_CARD_PLAY:String = 'player__CardPlay';
	public static const SELECT_DECK:String = 'selectDeck';
	public static const INTRO_EDIT_CLICK:String = 'introEditClick';
	
	public static const SPELL_SELECT:String = 'spellSelect';
	public static const END_SPELL_SELECT:String = 'spellEndSelect';
	public static const CANSEL_SPELL_SELECT:String = 'cancelSpellSelect';
	public static const WRONG_SPELL_SELECT_TARGET:String = 'wronr_spell_select_target';
	
	public static const START_DRAWING:String = 'startDrawing';
	public static const SKIP_DRAWING:String = 'skipDrawing';
	
	public static const GLOW_CARDS:String = 'glowCards';
	
	public static const CANCEL_SPELL_SELECT_FOR_EFFECT:String = 'cancelSpellSelectForEffect';
	public static const END_SPELL_SELECT_FOR_EFFECT:String = 'endSpellSelectForEffect';

    private var _data:Object;

    public function DeckEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        _data = data;
        super(type, bubbles, cancelable);
    }

    public function get data () :Object {
        return _data;
    }

    override public function clone():Event {
        return new DeckEvent(type, data, bubbles, cancelable);
    }
}

}