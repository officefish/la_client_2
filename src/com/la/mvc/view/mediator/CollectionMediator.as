/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.view.mediator {
<<<<<<< HEAD
import com.la.event.CollectionEvent;
import com.la.mvc.view.collection.ICollection;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import org.robotlegs.mvcs.Mediator;

public class CollectionMediator extends Mediator {

<<<<<<< HEAD
    [Inject (name='collection')]
	public var collection:ICollection; 
		
	override public function onRegister():void {
		eventMap.mapListener(collection, CollectionEvent.CLOSE, listener);
		eventMap.mapListener(collection, CollectionEvent.NEW_DECK, listener);
		eventMap.mapListener(collection, CollectionEvent.SAVE_DECK, listener);
		eventMap.mapListener(collection, CollectionEvent.SELECT_HERO, listener);
		eventMap.mapListener(collection, CollectionEvent.RESET_DECK, listener);
    }

    private function listener(event:CollectionEvent) :void {
		dispatch(event);
    }
	
=======
    override public function onRegister():void {

    }

>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    override public function onRemove():void {
        super.onRemove()
    }
}
}