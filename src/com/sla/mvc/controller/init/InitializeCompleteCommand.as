package com.sla.mvc.controller.init 
{
	import com.sla.event.IntroEvent;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitializeCompleteCommand extends StarlingCommand 
	{
		override public function execute():void 
		{
			dispatch (new IntroEvent(IntroEvent.STARTUP));
		}		
	}

}