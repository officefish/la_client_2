package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.view.field.deck.FieldDeckSlot;
	import com.la.mvc.view.scene.IScene;
	import flash.display.Sprite;
	import flash.geom.Point;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreviewFieldDeckSlotCommand extends Command 
	{
		[Inject]
		public var event:DeckEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
				
		override public function execute():void 
		{
			var slot:FieldDeckSlot = event.data.slot;
			var mirror:Sprite = slot.getMirror();
			var position:Point = new Point (slot.x, slot.y);
			position = slot.parent.localToGlobal(position);
			mirror.x = position.x;
			mirror.y = position.y - 31;
			scene.placeCard(mirror);
		}		
	}

}