package com.la.mvc.controller.match.attack 
{
	import com.la.event.ActionEvent;
	import com.la.event.TokenEvent;
	import com.la.mvc.model.MatchModel;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.IAttackAvailable;
	import com.la.mvc.view.field.IField;
	import com.la.mvc.view.field.IHero;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Command;
	import com.la.mvc.view.token.Token;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class StartAttackCommand extends Command 
	{
		
		[Inject]
		public var event:TokenEvent;
		
		[Inject (name='appConsole')]
		public var console:Console;  
		
		[Inject (name='scene')]
		public var scene:IScene;
		
		[Inject (names = 'matchModel')]
		public var model:MatchModel;
		
		[Inject (name='field')]
		public var field:IField;
		
		override public function execute():void 
		{
			var attackUnit:DisplayObject = event.getTokenDO();
			model.setAttackUnit (attackUnit);
			var xPosition:int = attackUnit.x + attackUnit.parent.x + Token.WIDTH/2;
            var yPosition:int = attackUnit.y + + attackUnit.parent.y + (attackUnit.height / 2);
            scene.setAttackTokenPosition (new Point (xPosition, yPosition));
			scene.clear();
			scene.startDraw();
			
			
			contextView.stage.addEventListener (MouseEvent.MOUSE_UP, onMouseUp); 
		}
		
		private function onMouseUp (event:MouseEvent) :void {
			contextView.stage.removeEventListener (MouseEvent.MOUSE_UP, onMouseUp); 
			scene.stopDraw();
			
			if  (event.target is IAttackAvailable) {
				var target:IAttackAvailable = event.target as IAttackAvailable;
				if (target.isEnemy) {
					var targetIndex:int;
					var attackUnitIndex:int;
					if (target is IHero) {
						targetIndex = - 1;
					} else {
						targetIndex = field.getTokenIndex (target as DisplayObject, true);
					}
					
					attackUnitIndex = field.getTokenIndex (model.getAttackUnit());
					dispatch (new ActionEvent (ActionEvent.CLASSIC_ATTACK, attackUnitIndex, targetIndex));
				}
			}
		}
		
	}

}