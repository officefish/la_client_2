package com.sla.mvc.controller.match.scenario.action.hand 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.view.hand.PlayerHand;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class GlowCardsCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var hand:PlayerHand;
		
		[Inject]
		public var matchModel:MatchModel;
		
		override public function execute():void 
		{
			if (event.data.client) {
				hand.glowCards (matchModel.mana, matchModel.numMinions);
			}
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}		
	}

}