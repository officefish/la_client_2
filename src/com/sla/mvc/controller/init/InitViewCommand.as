package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;  
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitViewCommand extends StarlingCommand 
	{
		override public function execute():void 
		{
			super.execute();
			MonsterDebugger.log("InitViewCommand::execute()");
			dispatch(new LAContextEvent(LAContextEvent.VIEW_INIT)); 
		}		
	}

}