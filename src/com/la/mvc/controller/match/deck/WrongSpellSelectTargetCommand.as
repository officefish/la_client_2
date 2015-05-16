package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.event.SceneEvent;
	import com.la.locale.Warning;
	import com.la.mvc.view.field.IHero;
	import com.la.mvc.view.scene.IScene;
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class WrongSpellSelectTargetCommand extends Command 
	{
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero; 
		
		[Inject]
		public var event:DeckEvent;
		
		override public function execute():void 
		{
			// warning;
			var heroDO:DisplayObject = playerHero as DisplayObject;
			var position:Point = new Point (heroDO.x + heroDO.width, heroDO.y);
			scene.playerHeroMessage (Warning.WRONG_SPELL_TARGET, position); 
			
			if (event.data.effect) {
				dispatch (new SceneEvent (SceneEvent.SELECT_TARGET_FOR_EFFECT, { }));
			} else {
				dispatch (new DeckEvent (DeckEvent.SPELL_SELECT, {}));
			}
			
			
		}		
	}

}