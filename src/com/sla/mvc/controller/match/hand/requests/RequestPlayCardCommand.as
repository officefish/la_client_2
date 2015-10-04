package com.sla.mvc.controller.match.hand.requests {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.HandEvent;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.service.MatchService;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.field.Field;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RequestPlayCardCommand extends StarlingCommand 
	{
		[Inject]
		public var event:HandEvent;
		
		[Inject]
		public var field:Field;
		
		[Inject]
		public var service:MatchService;
		
		[Inject]
		public var matchModel:MatchModel; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('RequestPlayCardCommand::execute()');
			matchModel.block = true;
			var card:Card = event.data.card;
			card.block = true;
			var type:int = card.getCardData().type;
			var index:int = event.data.index;
			var position:int = field.getMinionPreviewIndex();
			var serviceData:Object = { }
			serviceData.index = index;
			serviceData.cardType = type;
			serviceData.position = position;
			service.sendMessage('play_card', serviceData);
		}		
	}

}