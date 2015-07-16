package com.sla.mvc.controller.bootstrap 
{
	import com.sla.mvc.service.ApiService;
	import org.robotlegs.core.IInjector;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapService 
	{
		
		public function BootstrapService(injector:IInjector)  
		{
			injector.mapSingleton(ApiService); 
		}
		
	}

}