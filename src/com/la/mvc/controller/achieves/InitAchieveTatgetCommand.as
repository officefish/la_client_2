package com.la.mvc.controller.achieves 
{
	import com.la.event.FieldEvent;
	import com.la.mvc.model.RootModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.deck.PlayerDeck;
	import com.la.mvc.view.field.FieldAchieveSlot;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IHero;
	import com.la.mvc.view.IAttackAvailable;
	import com.la.mvc.view.scene.IScene;
	import com.la.state.GameState;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class InitAchieveTatgetCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='playerDeck')]
		public var playerDeck:PlayerDeck; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject]
		public var event:FieldEvent;
		
		[Inject (namespace = 'rootModel')]
		public var rootModel:RootModel; 
		
		private var playDistance:int;
		private var slot:FieldAchieveSlot;
		
		[Inject (name='field')]
		public var field:IField; 
		
		override public function execute():void 
		{
			//super.execute();
			rootModel.currentState = GameState.SPELL_SELECT; 
			
			playDistance = playerDeck.getPlayDistance();
			
			slot = event.getData().slot;
			var position:Point = new Point(slot.x + 30, slot.y + 30);
            scene.setAttackTokenPosition (position);
			
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
				data['position'] = slot.getPosition();
				
				rootModel.currentState = GameState.PLAYER_STEP;
				dispatch (new FieldEvent (FieldEvent.ACHIEVE_TARGET_INIT, data));
							
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
				data['position'] = slot.getPosition();

				rootModel.currentState = GameState.PLAYER_STEP;
				dispatch (new FieldEvent (FieldEvent.ACHIEVE_TARGET_INIT, data));

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
			}
		}
	}

}