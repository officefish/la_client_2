package com.sla.mvc.controller.bootstrap 
{
	
	import org.robotlegs.core.IStarlingMediatorMap;
	
	import com.sla.mvc.view.intro.Intro;
	import com.sla.mvc.view.mediator.IntroMediator;
	import com.sla.mvc.view.deck.DeckList;
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
		}
		
	}

}