/**
 * Created by root on 11/9/14.
 */
package com.la.mvc.view.card {
import com.la.event.CardEvent;
import com.la.mvc.model.CardData;
import flash.events.MouseEvent;

public class PreflopCard extends Card {

    private var _select:Boolean;

    public function PreflopCard(cardData:CardData) {
       super (cardData);
       while (numChildren) removeChildAt(0);
       addChild(getMirror());
       addEventListener(MouseEvent.CLICK, onClick);
    }

    override public function glow () :void {
        super.glow();
		_select = true;
        glowMirror();
    }

    override public function stopGlow () :void {
        super.stopGlow();
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
