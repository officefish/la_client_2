package com.la.mvc.controller.achieves 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.event.FieldEvent;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.FieldAchieveSlot;
	import com.la.mvc.view.scene.IScene;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MatchAchievePreviewCommand extends Command 
	{
		
		[Inject]
		public var event:FieldEvent;
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		private var slot:FieldAchieveSlot;
		
		
		override public function execute():void 
		{
			//console.debug ('matchAchievePreviewCommand::execute');
			slot = event.getData().slot;
			var mirror:Sprite = slot.getMirror();
			var position:Point = new Point(slot.x, slot.y);
			position = slot.parent.localToGlobal(position);
			
			mirror.x = position.x - 40;
			mirror.y = position.y - 200;
			
			if (slot.isEnemyAchieve) {
				mirror.y = position.y + 80;
			}
			
			scene.placeCard (mirror);
			mirror.alpha = 0;
			
			TweenLite.to (mirror, 1, { alpha:1, delay:1.0, ease:Expo.easeOut } );
			
		}		
	}

}