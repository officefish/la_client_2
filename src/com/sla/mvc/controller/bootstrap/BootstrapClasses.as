package com.sla.mvc.controller.bootstrap 
{
	import org.robotlegs.core.IInjector;
	import com.sla.mvc.view.deck.DeckList;
	import com.sla.mvc.view.intro.Intro;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapClasses 
	{
		
		public function BootstrapClasses(injector:IInjector)  
		{
			injector.mapSingleton(Intro);
			injector.mapSingleton(DeckList);
		}
		
	}

}