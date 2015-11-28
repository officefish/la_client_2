/**
 * Created by root on 10/23/14.
 */
package com.la.state {
import enumeration.UintEnumeration;

public class GameState extends UintEnumeration {

    public static const INTRO:GameState                 =  new GameState(0);
    public static const MATCH:GameState                 =  new GameState(1);
    public static const ARENA:GameState                 =  new GameState(2);
    public static const COLLECTION:GameState            =  new GameState(3);
    public static const MARKET:GameState                =  new GameState(4);
    public static const QUEST:GameState                 =  new GameState(5);
    public static const STUDY:GameState                 =  new GameState(6);
    public static const LOBBY:GameState                 =  new GameState(7);
    public static const DECK_LIST:GameState             =  new GameState(8);
    public static const PREFLOP:GameState               =  new GameState(9);
    public static const PREFLOP_SELECT:GameState        =  new GameState(10);
    public static const PLAYER_STEP_PREVIEW:GameState   =  new GameState(11);
    public static const PLAYER_STEP:GameState           =  new GameState(12);
    public static const OPPONENT_STEP:GameState         =  new GameState(13);
	public static const PLAYER_STEP_ACTION:GameState    =  new GameState(14);
	public static const OPPONENT_STEP_ACTION:GameState  =  new GameState(15);
	public static const COLLECTION_PREVIEW:GameState    =  new GameState(16);
	public static const EDIT_DECK:GameState             =  new GameState(17);
	public static const CLOSE_MATCH_INTRO:GameState     =  new GameState(18); 
	public static const CRAFT_COLLECTION:GameState      =  new GameState(19);
	public static const SPELL_SELECT:GameState			=  new GameState(20);
	public static const SELECT_EFFECT:GameState			=  new GameState(21);
	public static const END_MATCH:GameState				=  new GameState(22);
	public static const HEROES:GameState				=  new GameState(23);
	public static const HEROES_PREVIEW:GameState        =  new GameState(24);  
   


    public function GameState(value:uint) {
        super (value);
    }
}
}
