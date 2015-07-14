/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.init {
import com.la.event.GameContextEvent;
import com.la.mvc.model.HeroModel;
import com.la.mvc.model.RootModel;
import com.la.mvc.view.debug.Console;
import com.la.mvc.view.field.Hero;

import org.robotlegs.mvcs.Command;

public class InitModelCommand extends Command {

    [Inject (name='rootModel')]
    public var rootModel:RootModel;

    [Inject (name='heroModel')]
    public var heroModel:HeroModel;
	
	[Inject (name='appConsole')]
	public var console:Console; 

    override public function execute():void {

        rootModel.init ();
		var flashVars:Object = contextView.stage.loaderInfo.parameters; 
		if (flashVars["userId"]) {
			rootModel.username = flashVars["username"];
			rootModel.userId = flashVars["userId"];
		} else {
			console.debug('пользователь не установлен')
			rootModel.username = 'admin';
			rootModel.userId = 1;
		}

		
    }
}
}