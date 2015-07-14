package com.la.mvc.view.mediator 
{
	import com.la.event.CardEvent;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.AchieveCraftCard;
	import com.la.state.GameState;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveCraftCardMediator extends Mediator 
	{
		[Inject]
		public var card:AchieveCraftCard;
		
		[Inject (name = 'rootModel')]
		public var rootModel:RootModel; 
		
		
		override public function onRegister():void 
		{
			eventMap.mapListener(card, MouseEvent.CLICK, onMouseClick);
		}	
		
		private function onMouseClick (event:MouseEvent) :void {
			if (rootModel.currentState == GameState.HEROES) {
				dispatch(new CardEvent(CardEvent.CRAFT_ACHIEVE, {'card':card})) 
			}
			
		}
		
	}

}