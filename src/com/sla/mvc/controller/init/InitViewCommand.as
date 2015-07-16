package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import com.sla.theme.LastArgumentTheme;
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
			
			// init main theme
			new LastArgumentTheme ();
			
			MonsterDebugger.log("InitViewCommand::execute()");
			dispatch(new LAContextEvent(LAContextEvent.VIEW_INIT)); 
		}		
	}

}