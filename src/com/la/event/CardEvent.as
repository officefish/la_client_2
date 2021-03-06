/**
 * Created by root on 11/14/14.
 */
package com.la.event {
import flash.events.Event;

public class CardEvent extends Event {

    private var _data:Object;

    public static const PREFLOP_CLICK:String = 'preflopClick';
	public static const COLLECTION_CLICK:String = 'collectionClick';
	public static const DRAG_CARD:String = 'DragCardCollection';
	public static const DRAG_SLOT:String = 'DragSlotCollection';
	public static const DRAG_ACHIEVE_CARD:String = 'dragAchieveCard';
	public static const DRAG_ACHIEVE_SLOT:String = 'dragAchieveSlot';
	public static const CRAFT_ACHIEVE:String = 'craftAchieve';

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