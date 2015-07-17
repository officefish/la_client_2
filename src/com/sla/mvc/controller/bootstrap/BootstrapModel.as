package com.sla.mvc.controller.bootstrap 
{
	import com.sla.mvc.model.DeckListModel;
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
			injector.mapSingleton(StateModel, 'stateModel');
			injector.mapSingleton(DeckListModel);
		}
		
	}

}