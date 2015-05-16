/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.deck {
import com.la.mvc.view.card.Card;
import com.la.mvc.model.CardData;


public interface IDeck {
    function addCard (card:CardData, quick:Boolean = false) :Card;
    function addCards (cards:Vector.<CardData>, quick:Boolean = false) :Vector.<Card>;
    function resize (stageWidth:int, stageHeight:int) :void;
    function get shiftX () :int;
    function sort (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false):void;

}
}
