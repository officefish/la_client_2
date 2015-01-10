/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
<<<<<<< HEAD
import com.la.mvc.service.ApiService;
=======
import com.la.mvc.service.DeckService;
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
import com.la.mvc.service.LobbyService;
import com.la.mvc.service.MatchService;

import org.robotlegs.core.IInjector;

public class BootstrapService {
    public function BootstrapService(injector:IInjector) {
        injector.mapSingleton(LobbyService);
<<<<<<< HEAD
        injector.mapSingleton(MatchService);
		injector.mapSingleton(ApiService)
=======
        injector.mapSingleton(DeckService);
        injector.mapSingleton(MatchService);
>>>>>>> 26440aade46c09ee0a6b6f85ed8c3c6499e415a2
    }
}
}
