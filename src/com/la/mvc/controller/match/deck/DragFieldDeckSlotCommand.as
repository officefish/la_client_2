package com.la.mvc.controller.match.deck 
{
	import com.la.event.DeckEvent;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.deck.FieldDeckSlot;
	import com.la.mvc.view.scene.IScene;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DragFieldDeckSlotCommand extends Command 
	{
		[Inject]
		public var event:DeckEvent;
		
		[Inject (name='scene')]
		public var scene:IScene; 
		
		[Inject (name='appConsole')]
		public var console:Console; 
		
		private var slot:FieldDeckSlot;
		private var position:Point;
		
		
		override public function execute():void 
		{
			slot = event.data.slot;
			//slot.mouseEnabled = false;
			slot.drugMode = true;
			slot.parent.addChild(slot);
			slot.parent.parent.addChild(slot.parent);
			
			position = new Point(slot.x, slot.y);
			
			//var position:Point = new Point(slot.x, slot.y);
			//position = slot.parent.localToGlobal(position);
			//scene.placeCard(slot);
			
			//console.debug(widgetPosition.toString());
			var index:int = slot.index;
			var cof:int = Math.floor(index / 8)
			
			slot.startDrag(false, new Rectangle(25, 0 - 25 * cof, 175, 75)); 
			
			contextView.stage.addEventListener (MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		private function onStageMouseUp(event:MouseEvent) :void {
			//if (event.target)
			//console.debug (event.target.dropTarget.toString())
			slot.stopDrag();
			slot.drugMode = false;
			contextView.stage.removeEventListener (MouseEvent.MOUSE_UP, onStageMouseUp);
			var targetIndex:int;
			if (slot.dropTarget is FieldDeckSlot) {
				targetIndex = (slot.dropTarget as FieldDeckSlot).index;
				dispatch(new DeckEvent(DeckEvent.REPLACE_DECK_ITEMS, {initiator:slot.index, target:targetIndex}));
			} else if (slot.dropTarget.parent is FieldDeckSlot) {
				targetIndex = (slot.dropTarget.parent as FieldDeckSlot).index;
				dispatch(new DeckEvent(DeckEvent.REPLACE_DECK_ITEMS, {initiator:slot.index, target:targetIndex}));
			} else {
				slot.x = position.x;
				slot.y = position.y;
			}
						
			
			

		}
		
		
	}

}