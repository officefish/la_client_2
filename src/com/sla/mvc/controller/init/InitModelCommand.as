package com.sla.mvc.controller.init 
{
	import com.sla.event.LAContextEvent;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.demonsters.debugger.MonsterDebugger;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitModelCommand extends StarlingCommand 
	{
		override public function execute():void 
		{
			super.execute();
			/*
				var flashVars:Object = contextView.stage.loaderInfo.parameters; 
			*/
			MonsterDebugger.log ("InitModelCommand::execute()");
			
			dispatch(new LAContextEvent(LAContextEvent.MODEL_INIT));
		}		
	}

}