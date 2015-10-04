package com.sla.mvc.view.mediator 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.CollectionEvent;
	import com.sla.event.starling.StarlingCollectionEvent;
	import com.sla.mvc.model.StateModel;
	import com.sla.state.GameState;
	import org.robotlegs.mvcs.StarlingMediator;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionCardMediator extends StarlingMediator 
	{
		[Inject]
		public var stateModel:StateModel;
		
		override public function onRegister():void 
		{
			addViewListener(StarlingCollectionEvent.PREVIEW, onPreview); 
		}
		
		private function onPreview (event:StarlingCollectionEvent) :void {
			switch(stateModel.state) {
				case GameState.COLLECTION: {
					dispatch(new CollectionEvent(CollectionEvent.PREVIEW_CARD, event.data));
					break;
				}
				case GameState.EDIT_DECK: {
					dispatch(new CollectionEvent(CollectionEvent.ADD_TO_DECK, event.data));
					break;
				}
			}
			
		}
	}

}