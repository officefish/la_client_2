/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.view {
<<<<<<< HEAD
import com.la.mvc.model.CardData;
=======
import com.ps.cards.CardData;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import flash.events.IEventDispatcher;

public interface IGame extends IEventDispatcher {
    function resize (stageWidth:int, stageHeight:int) :void;
    function startup (collection:Vector.<CardData>) :void;
}
}
