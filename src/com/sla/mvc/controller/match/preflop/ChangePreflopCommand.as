package com.sla.mvc.controller.match.preflop 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.MatchServiceEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.scene.PreflopPopup;
	import org.robotlegs.mvcs.StarlingCommand;
	import com.sla.state.GameState;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ChangePreflopCommand extends StarlingCommand 
	{
		
		[Inject]
		public var stateModel:StateModel; 
		
		[Inject]
		public var event:MatchServiceEvent; 
		
		[Inject]
		public var preflop:PreflopPopup; 
		
		
		override public function execute():void 
		{
			MonsterDebugger.log("ChangePreflopCommand::execute()");
			stateModel.state = GameState.PREFLOP_SELECT;
			
			var cardDatas:Vector.<CardData> = getCardDataVector(event.data.preflop);;
			preflop.replaceCards(cardDatas);
		}	
		
		private function getCardDataVector (data:Array) :Vector.<CardData> {
			var vector:Vector.<CardData> = new Vector.<CardData>();
			var cardData:CardData
			for (var i:int = 0; i < data.length; i ++) {
				cardData = CardData.converToData (data[i])
				vector.push(cardData)
			}
			return vector; 
		}
	}

}