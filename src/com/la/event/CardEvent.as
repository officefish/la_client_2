/**
 * Created by root on 11/14/14.
 */
package com.la.event {
import flash.events.Event;

public class CardEvent extends Event {

    private var _data:Object;

    public static const PREFLOP_CLICK:String = 'preflopClick';
<<<<<<< HEAD
	public static const COLLECTION_CLICK:String = 'collectionClick';
	public static const DRAG_CARD:String = 'DragCardCollection';
	public static const DRAG_SLOT:String = 'DragSlotCollection';

=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    public function CardEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
        _data = data;
        super(type, bubbles, cancelable);
    }

    public function get data () :Object {
        return _data;
    }

    override public function clone():Event {
        return new CardEvent(type, data, bubbles, cancelable);
    }
}

}