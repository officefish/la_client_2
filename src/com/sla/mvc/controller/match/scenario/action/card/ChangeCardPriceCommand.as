package com.sla.mvc.controller.match.scenario.action.card 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.card.Card;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ChangeCardPriceCommand extends CardActionCommand
	{
		[Inject]
		public var event:ScenarioEvent;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('ChangeCardPriceCommand::execute()');
			var client:Boolean = event.data.client;
			var card:Card = getCard(event.data.index, event.data.attachment, client); 
			card.setPrice(event.data.price);
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION)); 
		}		
	}

}