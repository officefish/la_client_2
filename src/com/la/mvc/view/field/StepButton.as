/**
 * Created by root on 11/15/14.
 */
package com.la.mvc.view.field {
<<<<<<< HEAD
import com.la.event.FieldEvent;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;

public class StepButton extends Sprite {

    private var label:TextField;

    public function StepButton() {
        graphics.beginFill (0x444444, 1);
        graphics.drawRect (0, 0, 100, 40);
        graphics.endFill();

        buttonMode = true;

        var format:TextFormat = new TextFormat ();
        format.color = 0xFFFFFF;
        format.size = 15;

        label = new TextField ();
        label.defaultTextFormat = format;
        label.text = "Закончить";
        label.autoSize = TextFieldAutoSize.LEFT;
        label.wordWrap = false;
        //label.border = true;
        label.x = (this.width - label.width) / 2
        label.y = 10;
        label.mouseEnabled = false;
        addChild (label);
    }

    public function enable () :void {
        this.addEventListener(MouseEvent.CLICK, onClick);
        this.filters = [new GlowFilter(0x4CC417)]
    }

    public function disable () :void {
        this.removeEventListener(MouseEvent.CLICK, onClick);
        this.filters = null;
    }

    private function onClick (event:MouseEvent) :void {
<<<<<<< HEAD
		dispatchEvent (new FieldEvent (FieldEvent.END_STEP))
=======

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }
}
}
