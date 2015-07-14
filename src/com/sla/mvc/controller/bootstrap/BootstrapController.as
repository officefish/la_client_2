package com.sla.mvc.controller.bootstrap 
{
	import com.sla.event.LAContextEvent;
	import com.sla.mvc.controller.intro.StartupIntroCommand;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.ICommandMap;
	import com.sla.mvc.controller.init.*;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapController 
	{
		public function BootstrapController(commandMap:ICommandMap)  
		{
			
			// -- Initialisation --
			/* All initialisation realise in bootstrap classes but here we can configure some special things
			 * for example add some flashvars to model, configure service links, starling settings and so on 
			 */
			// init model
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, InitModelCommand, ContextEvent);
			// init services
			commandMap.mapEvent(LAContextEvent.MODEL_INIT, InitServiceCommand, LAContextEvent);
			// init view
			commandMap.mapEvent(LAContextEvent.SERVICE_INIT, InitViewCommand, LAContextEvent);
			
			// -- Intro --
			/*
			 *  Finally we launch our intro menu 
			 */  
			
			commandMap.mapEvent(LAContextEvent.VIEW_INIT, StartupIntroCommand);
		}
		
	}

}