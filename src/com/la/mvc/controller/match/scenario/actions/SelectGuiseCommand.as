package com.la.mvc.controller.match.scenario.actions 
{
	import com.la.event.ScenarioEvent;
	import com.la.event.SceneEvent;
	import com.la.mvc.model.DeckModel;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectGuiseCommand extends Command 
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name = 'matchModel')]
		public var model:MatchModel;  
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (name='deckModel')]
		public var deckModel:DeckModel; 
		
		private var mirrors:Array; 
		
		override public function execute():void 
		{
			var drawingCard:Card = deckModel.drawingCard;
			if (drawingCard.getMirror().parent) {
				drawingCard.getMirror().visible = false;
			}
			
			var cardDatas:Array = event.data.cards;
			
			var cardsTotalWidth:int = cardDatas.length * Card.MIRROR_WIDTH;
			var totalShift:int = (cardDatas.length - 1) * 20;
			var startX:int = (contextView.stage.stageWidth - (cardsTotalWidth + totalShift)) / 2;
			var shift:int = 20;
			
			scene.darken();
			
			mirrors = []
			
			for (var i:int = 0; i < cardDatas.length; i ++) {
				var card:Card = new Card (cardDatas[i]);
				card.setSpellMixin(model.getSpellMixin());
				var mirror:Sprite = card.getMirror();
				mirror.buttonMode = true;
				scene.placeCopy(mirror);
				mirror.x = startX;
				mirror.y = (contextView.stage.stageHeight - Card.MIRROR_HEIGHT) / 2;
				startX += (Card.MIRROR_WIDTH + shift);
				mirrors.push(mirror);
				mirror.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				mirror.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				mirror.addEventListener(MouseEvent.CLICK, onMouseClick);
			}
			
			rootModel.currentState = GameState.SELECT_EFFECT; 
			
			dispatch (new ScenarioEvent (ScenarioEvent.ACTION));
		}	
		
		private function onMouseOver (event:MouseEvent) :void {
			event.target.filters = [new GlowFilter(0x00FFFF)] 
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			event.target.filters = [];
		}
		
		private function onMouseClick (event:MouseEvent) :void {
			var index:int = mirrors.indexOf(event.target);
			destroyListeners();
			scene.lighten(false);
			scene.endCopy();
			
			rootModel.currentState = GameState.PLAYER_STEP;
			
			dispatch (new SceneEvent (SceneEvent.GUISE_SELECTED, { index:index } ));
		}
		
		private function destroyListeners () :void {
			for (var i:int = 0; i < mirrors.length; i ++) {
				var mirror:Sprite = mirrors[i];
				mirror.removeEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				mirror.removeEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				mirror.removeEventListener(MouseEvent.CLICK, onMouseClick);
			}
			mirrors = null;
		}
	
	}

}