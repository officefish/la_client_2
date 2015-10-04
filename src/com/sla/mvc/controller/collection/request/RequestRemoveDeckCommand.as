package com.sla.mvc.controller.collection.request 
{
	import com.demonsters.debugger.MonsterDebugger;
	import flash.events.Event;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestRemoveDeckCommand extends StarlingCommand 
	{
		override public function execute():void 
		{
			MonsterDebugger.log('RequestRemoveDeckCommand::execute');
		}
	}

}