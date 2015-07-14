package com.sla.mvc.controller.bootstrap 
{
	import org.robotlegs.core.ICommandMap;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapController 
	{
		public function BootstrapController(commandMap:ICommandMap)  
		{
			// Launch application;
			// init model
			//commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitModelCommand, ContextEvent);
			// init services
			//commandMap.mapEvent(GameContextEvent.MODEL_INIT_COMPLETE, InitServiceCommand, GameContextEvent);
			// init view
			//commandMap.mapEvent(GameContextEvent.SERVICE_INIT_COMPLETE, InitViewCommand, GameContextEvent);
		}
		
	}

}