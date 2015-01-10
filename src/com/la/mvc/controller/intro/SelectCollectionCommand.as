/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.intro {
import com.la.mvc.model.RootModel;
<<<<<<< HEAD
import com.la.mvc.view.collection.ICollection;
import com.la.state.GameState;
import com.la.mvc.service.ApiService;
=======
import com.la.mvc.view.ICollection;
import com.la.state.GameState;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

import flash.display.DisplayObject;

import org.robotlegs.mvcs.Command;

public class SelectCollectionCommand extends Command {

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    [Inject (name='collection')]
    public var collection:ICollection;
<<<<<<< HEAD
	
	[Inject]
	public var service:ApiService;
=======
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2

    override public function execute():void {

        contextView.addChildAt(collection as DisplayObject, 0);
<<<<<<< HEAD
		collection.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
        rootModel.currentState = GameState.COLLECTION;
		
		service.requestCollection (1);
=======
        rootModel.currentState = GameState.COLLECTION;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }
}
}