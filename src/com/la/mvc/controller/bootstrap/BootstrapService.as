/**
 * Created by root on 10/23/14.
 */
package com.la.mvc.controller.bootstrap {
import com.la.mvc.service.ApiService;
import com.la.mvc.service.DeckService;
import com.la.mvc.service.LobbyService;
import com.la.mvc.service.MatchService;

import org.robotlegs.core.IInjector;

public class BootstrapService {
    public function BootstrapService(injector:IInjector) {
        injector.mapSingleton(LobbyService);
        injector.mapSingleton(MatchService);
		injector.mapSingleton(ApiService)
        injector.mapSingleton(DeckService);
        injector.mapSingleton(MatchService);
    }
}
}
