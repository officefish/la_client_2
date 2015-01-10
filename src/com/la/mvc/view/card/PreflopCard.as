/**
 * Created by root on 11/9/14.
 */
package com.la.mvc.view.card {
import com.la.event.CardEvent;
<<<<<<< HEAD
import com.la.mvc.model.CardData;
=======
import com.ps.cards.CardData;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import flash.events.MouseEvent;

public class PreflopCard extends Card {

    private var _select:Boolean;

    public function PreflopCard(cardData:CardData) {
       super (cardData);
       while (numChildren) removeChildAt(0);
       addChild(getMirror());
       addEventListener(MouseEvent.CLICK, onClick);
    }

    public function glow () :void {
        _select = true;
        glowMirror();
    }

    public function stopGlow () :void {
        _select = false;
        stopGlowMirror();
    }

    public function get select () :Boolean {
        return _select;
    }

    private function onClick (event:MouseEvent) :void {
        select ? stopGlow() : glow();

        var index:int = this.parent.getChildIndex(this);
        dispatchEvent(new CardEvent (CardEvent.PREFLOP_CLICK, {'index':index, 'select':select} ))
    }

    public function block () :void {
        if (hasEventListener(MouseEvent.CLICK)) {
            removeEventListener(MouseEvent.CLICK, onClick);
        }
    }
}
}
