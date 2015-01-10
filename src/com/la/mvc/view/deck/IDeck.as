/**
 * Created by root on 10/25/14.
 */
package com.la.mvc.view.deck {
import com.la.mvc.view.card.Card;
<<<<<<< HEAD
import com.la.mvc.model.CardData;
=======
import com.ps.cards.CardData;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

public interface IDeck {
    function addCard (card:CardData, quick:Boolean = false) :Card;
    function addCards (cards:Vector.<CardData>, quick:Boolean = false) :Vector.<Card>;
    function resize (stageWidth:int, stageHeight:int) :void;
    function set price (value:int) :void;
    function get price () :int;
    function get shiftX () :int;
    function block () :void
<<<<<<< HEAD
    function unblock (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false) :void
	function sort (endAnimationFlag:Boolean = false, sygnalFlag:Boolean = false):void;
=======
    function unblock () :void
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
}
}
