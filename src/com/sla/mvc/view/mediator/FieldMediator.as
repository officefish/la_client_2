package com.sla.mvc.view.mediator 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.event.starling.StarlingFieldEvent;
	import com.sla.mvc.model.MatchModel;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldMediator extends StarlingMediator 
	{
		[Inject]
		public var matchModel:MatchModel;  
		
		override public function onRegister():void 
		{
			addViewListener(StarlingFieldEvent.END_STEP, onEndStep);
		}
		
		private function onEndStep (event:StarlingFieldEvent) :void {
			if (matchModel.block) return;
			dispatch(new ScenarioEvent(ScenarioEvent.END_STEP));
		}
	}

}