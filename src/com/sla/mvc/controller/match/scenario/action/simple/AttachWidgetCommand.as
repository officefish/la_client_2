package com.sla.mvc.controller.match.scenario.action.simple 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.controller.match.scenario.action.MinionActionCommand;
	import com.sla.mvc.view.field.minion.IMinion;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AttachWidgetCommand extends MinionActionCommand 
	{
		
		[Inject]
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			var client:Boolean = event.data.client;
			var target:IMinion = getTarget(event.data.index, event.data.attachment, client); 
			target.attachWidget(event.data.widget);
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			
		}		
		
	}

}