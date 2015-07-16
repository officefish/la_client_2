package com.sla.mvc 
{
	import org.robotlegs.mvcs.StarlingContext;
	import starling.display.DisplayObjectContainer;
	
	import com.sla.mvc.controller.bootstrap.*;
	
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LastArgumentContext extends StarlingContext 
	{
		
		public function LastArgumentContext(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true) 
		{
			super(contextView, autoStartup);
		}
		
		override public function startup():void 
		{
			
			bootstrap();
			super.startup();
		}
		
		/*
		 *  init model,view, controller, inject classes and servises 
		 */
		private function bootstrap () :void {
			new BootstrapClasses(injector);
			new BootstrapModel(injector);
			new BootstrapController(commandMap);
			new BootstrapService(injector);
			new BootstrapView(this.mediatorMap);
		}
		
	}

}