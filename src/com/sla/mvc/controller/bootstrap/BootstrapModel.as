package com.sla.mvc.controller.bootstrap 
{
	import com.sla.mvc.model.DeckListModel;
	import com.sla.mvc.model.HeroModel;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.RootModel;
	import com.sla.mvc.model.StateModel;
	import org.robotlegs.core.IInjector;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapModel 
	{
		public function BootstrapModel(injector:IInjector)  
		{
			injector.mapSingleton(StateModel);
			injector.mapSingleton(DeckListModel);
			injector.mapSingleton(HeroModel);
			injector.mapSingleton(RootModel);
			injector.mapSingleton(MatchModel);
		}
		
	}

}