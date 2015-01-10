/**
 * Created by root on 11/1/14.
 */
package com.la.mvc.controller.deck {
import com.la.mvc.service.ApiService;
import org.robotlegs.mvcs.Command;

public class RequestDeckListCommand extends Command {

    [Inject]
	public var service:ApiService; 

    override public function execute():void {
        service.requestDeckList(1);
    }
}
}