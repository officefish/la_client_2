package com.la.mvc.controller.match.scenario.actions 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IHero;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.IAttackAvailable;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectTargetForEffectCommand extends Command 
	{
		[Inject (name = 'playerHero')]
		public var playerHero:IHero; 
		
		[Inject (names = 'matchModel')]
		public var model:MatchModel;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='field')]
		public var field:IField; 
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		private var playDistance:int;
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		override public function execute():void 
		{
			super.execute();
			rootModel.currentState = GameState.SPELL_SELECT;
			
			playDistance = playerDeck.getPlayDistance();
			
			var attackUnit:DisplayObject = playerHero as DisplayObject; 
			model.setAttackUnit (attackUnit);
			var xPosition:int = attackUnit.x +  attackUnit.width/2;
            var yPosition:int = attackUnit.y + attackUnit.height/2;
            scene.setAttackTokenPosition (new Point (xPosition, yPosition)); 
			scene.clear();
			scene.startDraw(); 
			
			contextView.stage.addEventListener (MouseEvent.CLICK, onClick); 
			contextView.stage.addEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
		}		
		
		private function onClick (event:MouseEvent) :void {
			console.debug('SelectTargetForEffect.onClick')
			console.debug(event.target.toString())
			console.debug(event.target.parent.toString())
			console.debug(event.target.parent.parent.toString())
			
			
			if  (event.target is IAttackAvailable) { 
				
				console.debug('targetInit!')
				
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
				
				dispatch (new DeckEvent (DeckEvent.END_SPELL_SELECT_FOR_EFFECT, data));
			}
		}
		
		private function onMouseMove (event:MouseEvent) :void {
			
			if (contextView.mouseY > playDistance) {
				
				contextView.stage.removeEventListener (MouseEvent.MOUSE_MOVE, onMouseMove);
				contextView.stage.removeEventListener (MouseEvent.CLICK, onClick); 
				scene.stopDraw();
				
				if (contextView.stage.hasEventListener(MouseEvent.CLICK)) {
					contextView.stage.removeEventListener (MouseEvent.CLICK, onClick); 
				}
				dispatch (new DeckEvent (DeckEvent.CANCEL_SPELL_SELECT_FOR_EFFECT, {mouseX:contextView.mouseX, mouseY:contextView.mouseY}));
			}
		}
	}

}