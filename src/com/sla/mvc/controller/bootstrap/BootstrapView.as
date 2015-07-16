package com.sla.mvc.controller.bootstrap 
{
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.core.IStarlingMediatorMap;
	
	import com.sla.mvc.view.intro.IIntro;
	import com.sla.mvc.view.mediator.IntroMediator;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BootstrapView 
	{
		
		public function BootstrapView(mediatorMap:IStarlingMediatorMap)  
		{
			mediatorMap.mapView(IIntro, IntroMediator);
		}
		
	}

}