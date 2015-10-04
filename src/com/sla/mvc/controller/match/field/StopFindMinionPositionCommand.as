package com.sla.mvc.controller.match.field 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.FieldEvent;
	import com.sla.mvc.view.field.Field;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StopFindMinionPositionCommand extends StarlingCommand 
	{
		[Inject]
		public var field:Field;
		
		[Inject]
		public var event:FieldEvent;
		
		override public function execute():void 
		{
			MonsterDebugger.log('StopFindMinionPositionCommand::execute()');
			field.stopFindPosition(event.data.sort);
		}		
	}

}