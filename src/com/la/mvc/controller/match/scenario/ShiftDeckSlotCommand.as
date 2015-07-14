package com.la.mvc.controller.match.scenario 
{
	import com.greensock.easing.Expo;
	import com.greensock.easing.ExpoOut;
	import com.greensock.TweenLite;
	import com.la.event.ScenarioEvent;
	import com.la.mvc.view.debug.Console;
	import com.la.mvc.view.field.deck.FieldDeckRow;
	import com.la.mvc.view.field.deck.FieldDeckSlot;
	import com.la.mvc.view.field.deck.FieldDeckWidget;
	import com.la.mvc.view.field.FieldAchieveSlot;
	import com.la.mvc.view.field.IField;
	import flash.display.Sprite;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ShiftDeckSlotCommand extends Command 
	{
		[Inject (name='appConsole')]
		public var console:Console; 
		
		[Inject (name='field')]
		public var field:IField; 
		
		private var widget:FieldDeckWidget; 
		private var rows:Array;
		private var rails:Array;
		private var animCof:int;
				
				
		override public function execute():void 
		{
			widget = field.getDeckWidget();
			rows = widget.getRows();
			rails = []
			animCof = 0;
			var row:FieldDeckRow;
			var rail:Sprite;
			var slots:Array;
			var slot:FieldDeckSlot;
			
			for (var i:int = 0; i < rows.length; i ++) {
				row = rows[i];
				rail = new Sprite();
				rail.x = 25;
				slots = []
				for (var j:int = 0; j < row.numChildren; j ++) {
					slot = row.getChildAt(j) as FieldDeckSlot;
					slots.push(slot);
				}
				var nextRow:FieldDeckRow = widget.getRow(row.position + 1);
				if (nextRow) {
					if (nextRow.numChildren) {
						slot = nextRow.getChildAt(0) as FieldDeckSlot;
						slot = slot.clone();
						slots.push(slot);
					}
					
				}
				for (j = 0; j < slots.length; j ++) {
					slot = slots[j];
					rail.addChild(slot);
					slot.x = 25 * j;
				}
				row.addChild(rail);
				rails.push(rail);
				
			}
			
			for (j = 0; j < rails.length; j ++) {
				rail = rails[j];
				animCof ++;
				TweenLite.to(rail, 0.8, {x:0, ease:Expo.easeOut, onComplete:onTweenComplete});
			}
		}
		
		private function onTweenComplete () :void {
			animCof --;
			if (!animCof) {
				var slots:Array;
				var clearFlag:Boolean;
				var slot:FieldDeckSlot
				for (var i:int = 0; i < rails.length; i ++) {
					slots = [];
					clearFlag = true;
					var rail:Sprite = rails[i];
					if (rail.numChildren) {
						rail.removeChildAt(0);
					}
					var row:FieldDeckRow = rail.parent as FieldDeckRow;
					row.removeChild(rail);
					for (var j:int = 0; j < rail.numChildren; j ++) {
						slot = rail.getChildAt(j) as FieldDeckSlot;
						slots.push(slot);
					}
					for (j = 0; j < slots.length; j ++) {
						slot = slots[j];
						if (clearFlag) {
							row.clear();
							clearFlag = false;
						}
						row.addItem(slot);
					}
				}
				widget.reindexSlots();
				dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			}
		}
		
	}

}