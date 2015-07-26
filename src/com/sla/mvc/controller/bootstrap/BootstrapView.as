package com.sla.mvc.controller.bootstrap 
{
	
	import com.sla.mvc.view.lobby.Lobby;
	import com.sla.mvc.view.mediator.LobbyMediator;
	import org.robotlegs.core.IStarlingMediatorMap;
	
	import com.sla.mvc.view.intro.Intro;
	import com.sla.mvc.view.mediator.IntroMediator;
	import com.sla.mvc.view.decklist.DeckList;
	import com.sla.mvc.view.mediator.DeckListMediator;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapView 
	{
		
		public function BootstrapView(mediatorMap:IStarlingMediatorMap)  
		{
			mediatorMap.mapView(Intro, IntroMediator);
			mediatorMap.mapView(DeckList, DeckListMediator); 
			mediatorMap.mapView(Lobby, LobbyMediator);
		}
		
	}

}