/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.view.mediator {
import com.la.event.CollectionEvent;
import com.la.mvc.view.collection.ICollection;
import org.robotlegs.mvcs.Mediator;

public class CollectionMediator extends Mediator {

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
	
    override public function onRemove():void {
        super.onRemove()
    }
}
}