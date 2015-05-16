package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IHero;
	import com.la.mvc.view.IAttackAvailable;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.debug.Console;

	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SpellSelectCommand extends Command 
	{
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero; 
		
		[Inject (names = 'matchModel')]
		public var model:MatchModel;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='field')]
		public var field:IField;
		
		[Inject]
		public var event:DeckEvent;
		
		private var playDistance:int;
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		override public function execute():void 
		{
			rootModel.currentState = GameState.SPELL_SELECT;
			
			playDistance = playerDeck.getPlayDistance();
			
			var attackUnit:DisplayObject = playerHero as DisplayObject;
			model.setAttackUnit (attackUnit);
			var xPosition:int = attackUnit.x +  attackUnit.width/2;
            var yPosition:int = attackUnit.y + attackUnit.height/2;
            scene.setAttackTokenPosition (new Point (xPosition, yPosition)); 
			scene.clear();
			scene.startDraw();
			
			contextView.stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp); 
			contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onMouseUp (event:MouseEvent) :void {
			contextView.stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp); 
						
			if  (event.target is IAttackAvailable) { 
				
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
				scene.stopDraw();
								
				var target:IAttackAvailable = event.target as IAttackAvailable;
				var targetIndex:int;
				var attachment:int = 0;
				
				if (target.isEnemy) {
					attachment = 1;
					if (target is IHero) {
						targetIndex = - 1;
					} else {
						targetIndex = field.getTokenIndex (target as DisplayObject, true);
					}
				} else {
					if (target is IHero) {
						targetIndex = - 1;
					} else {
						targetIndex = field.getTokenIndex (target as DisplayObject);
					}
				}
				
				var data:Object = { };
				data['attachment'] = attachment
				data['targetIndex'] = targetIndex;
				
				rootModel.currentState = GameState.PLAYER_STEP;
				dispatch (new DeckEvent (DeckEvent.END_SPELL_SELECT, data));
							
			} else {
				contextView.stage.addEventListener (MouseEvent.CLICK, onClick); 
			}
		}
		
		private function onClick (event:MouseEvent) :void {
			if  (event.target is IAttackAvailable) { 
				
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
				contextView.stage.removeEventListener (MouseEvent.CLICK, onClick); 
				
				scene.stopDraw();
								
				var target:IAttackAvailable = event.target as IAttackAvailable;
				var targetIndex:int;
				var attachment:int = 0;
				
				if (target.isEnemy) {
					attachment = 1;
					if (target is IHero) {
						targetIndex = - 1;
					} else {
						targetIndex = field.getTokenIndex (target as DisplayObject, true);
					}
				} else {
					if (target is IHero) {
						targetIndex = - 1;
					} else {
						targetIndex = field.getTokenIndex (target as DisplayObject);
					}
				}
				
				var data:Object = { };
				data['attachment'] = attachment
				data['targetIndex'] = targetIndex;
				rootModel.currentState = GameState.PLAYER_STEP;
				dispatch (new DeckEvent (DeckEvent.END_SPELL_SELECT, data));
			}
		}
		
		private function onMouseMove (event:MouseEvent) :void {
			
			if (contextView.mouseY > playDistance) {
				
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
				scene.stopDraw();
				
				if (contextView.stage.hasEventListener(MouseEvent.CLICK)) {
					contextView.stage.removeEventListener (MouseEvent.CLICK, onClick); 
				}
				if (contextView.stage.hasEventListener(MouseEvent.MOUSE_UP)) {
					contextView.stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp); 
				}
				rootModel.currentState = GameState.PLAYER_STEP;
				dispatch (new DeckEvent (DeckEvent.CANSEL_SPELL_SELECT, {mouseX:contextView.mouseX, mouseY:contextView.mouseY}));
			}
		}
	}

}