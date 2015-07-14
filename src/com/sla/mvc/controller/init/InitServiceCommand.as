package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitServiceCommand extends StarlingCommand 
	{
		override public function execute():void 
		{
			super.execute();
			MonsterDebugger.log ("InitServiceCommand::execute()");
			dispatch(new LAContextEvent(LAContextEvent.SERVICE_INIT));
		}	
	}

}