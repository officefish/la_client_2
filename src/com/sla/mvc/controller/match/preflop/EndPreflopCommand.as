package com.sla.mvc.controller.match.preflop 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.MatchServiceEvent;
	import com.sla.event.SceneEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.model.MatchModel;
	import com.sla.mvc.model.StateModel;
	import com.sla.mvc.view.scene.PreflopPopup;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingCommand;
	
	
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EndPreflopCommand extends StarlingCommand 
	{
		[Inject]
		public var event:MatchServiceEvent; 
		
		[Inject]
		public var stateModel:StateModel; 
		
		[Inject]
		public var preflop:PreflopPopup; 
		
		[Inject]
		public var matchModel:MatchModel;
		
		
		override public function execute():void 
		{
			MonsterDebugger.log('EndPreflopCommand::execute()');
			//super.execute();
			MonsterDebugger.log ('currentState: ' + stateModel.state.value);
			switch (stateModel.state) {
				case GameState.PREFLOP_SELECT:
				{
					
					
					if (matchModel.preflopEndFlag) {
						return;
					}
					matchModel.preflopEndFlag = true;
					/*
					if (event.getData().mode == 2) {
						matchModel.initDeck(event.getData().deck);
						field.initDeck(matchModel.getDeck());
					}
					*/
					MonsterDebugger.log(event.data.preflop);
					var cards:Vector.<CardData> = getCardDataVector(event.data.preflop);
					dispatch(new SceneEvent(SceneEvent.START_HAND_CARDS_INIT, {cards:cards}))
					break;
				}
				case GameState.PREFLOP:
				{
					preflop.changePreflopCards();
					break;
				}
			}
		}
		
		private function getCardDataVector (data:Array) :Vector.<CardData> {
			var vector:Vector.<CardData> = new Vector.<CardData>();
			var cardData:CardData; 
			for (var i:int = 0; i < data.length; i ++) {
				cardData = CardData.converToData (data[i])
				vector.push(cardData)
			}
			return vector;
		}
	}

}