package com.sla.mvc.controller.match.field 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.mvc.view.field.Field;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FindMinionPositionCommand extends StarlingCommand 
	{
		[Inject]
		public var field:Field;
		
		override public function execute():void 
		{
			MonsterDebugger.log('FindMinionPositionCommand::execute()');
			field.findPosition();
		}	
	}

}