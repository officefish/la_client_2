package com.sla.mvc.controller.match.preflop 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.MatchServiceEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.model.DeckModel;
	import com.sla.mvc.model.MatchModel;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MatchConnectionInitCommand extends StarlingCommand 
	{
		[Inject]
		public var event:MatchServiceEvent; 
		
		[Inject]
		public var deckModel:DeckModel;
		
		[Inject]
		public var matchModel:MatchModel;
		
		override public function execute():void 
		{
			MonsterDebugger.log('MatchConnectionInitCommand');
			
			deckModel.init();
			
			var cardDatas:Vector.<CardData> = getCardDataVector(event.data.preflop);
			deckModel.addPlayerCards (cardDatas);

			cardDatas = getCardDataVector(event.data.opponent_preflop);
			deckModel.addOpponentCards (cardDatas);
			
			matchModel.mode = int (event.data.mode);
		
			matchModel.playerHero = event.data.hero;
			matchModel.opponentHero = event.data.opponent_hero;

			matchModel.playerHeroHealth = event.data.health;
			matchModel.opponentHeroHealth = event.data.opponent_health;
			
			matchModel.initPlayerAbilities (event.data.achieves);
			matchModel.initOpponentAbilities (event.data.opponent_achieves);
			
			matchModel.whiteFlag = event.data.white;
			
	        dispatch(new MatchServiceEvent(MatchServiceEvent.PREFLOP_INIT))

				
		}
		
		private function getCardDataVector (data:Array) :Vector.<CardData> {
			var vector:Vector.<CardData> = new Vector.<CardData>();
			for (var i:int = 0; i < data.length; i ++) {
				var cardData:CardData = CardData.converToData (data[i]);
				vector.push(cardData)
			}
			return vector; 
		}
	}

}