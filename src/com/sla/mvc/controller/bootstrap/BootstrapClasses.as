package com.sla.mvc.controller.bootstrap 
{
	import org.robotlegs.core.IInjector;
	import com.sla.mvc.view.intro.*;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapClasses 
	{
		
		public function BootstrapClasses(injector:IInjector)  
		{
			injector.mapClass(Intro, Intro);
		}
		
	}

}