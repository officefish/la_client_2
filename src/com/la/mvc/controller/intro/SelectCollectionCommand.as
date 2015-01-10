/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.intro {
import com.la.mvc.model.RootModel;
import com.la.mvc.view.collection.ICollection;
import com.la.state.GameState;
import com.la.mvc.service.ApiService;
import flash.display.DisplayObject;

import org.robotlegs.mvcs.Command;

public class SelectCollectionCommand extends Command {

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    [Inject (name='collection')]
    public var collection:ICollection;
	
	[Inject]
	public var service:ApiService;


    override public function execute():void {

        contextView.addChildAt(collection as DisplayObject, 0);
		collection.resize (contextView.stage.stageWidth, contextView.stage.stageHeight);
        rootModel.currentState = GameState.COLLECTION;
		service.requestCollection (1);

    }
}
}