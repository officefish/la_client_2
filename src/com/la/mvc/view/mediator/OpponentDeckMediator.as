package com.la.mvc.view.mediator 
{
	import com.la.event.ScenarioEvent;
	import com.la.mvc.view.deck.EnemyDeck;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class OpponentDeckMediator extends Mediator 
	{
		
		[Inject (name='enemyDeck')]
		public var enemyDeck:EnemyDeck; 
		
		override public function onRegister():void {
			eventMap.mapListener(enemyDeck, ScenarioEvent.ACTION, scenario); 
		}
		
		private function scenario (event:ScenarioEvent) :void {
			dispatch(event);
		}
	}

}