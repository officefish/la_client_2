package com.la.mvc.view.field.deck 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldDeckWidget extends Sprite 
	{
		private var rows:Array;
		private var slots:Object;
		private var widgetMask:Sprite;
				
		public function FieldDeckWidget() 
		{
			graphics.beginFill(0xFFFF00, 0.7);
			graphics.drawRect(0, 0, 199, 99);
			graphics.endFill();
			
			widgetMask = new Sprite();
			widgetMask.graphics.beginFill(0xFF0000, 0.5);
			widgetMask.graphics.drawRect(0, 0, 200, 100);
			widgetMask.graphics.endFill();
			addChild(widgetMask);
			this.mask = widgetMask;
			
			rows = [];
			for (var i:int = 0; i < 4;  i ++) {
				var row:FieldDeckRow = new FieldDeckRow();
				addChild(row);
				row.y += 25 * rows.length;
				row.x = - 25;
				row.position = i;
				rows.push(row);
			}
			
			
			
		}
		
		public function getRow (position:int) :FieldDeckRow {
			var row:FieldDeckRow;
			for (var i:int = 0; i < rows.length; i ++) {
				if (rows[i].position == position) {
					row = rows[i];
				}
			}
			return row;
		}
		
		public function getRows () :Array {
			return rows;
		}
		
		public function initDeck (deck:Array) :void {
			var j:int = 0;
			slots = {}
			for (var i:int = 0; i < deck.length; i ++) {
				var slot:FieldDeckSlot = new FieldDeckSlot(deck[i]);
				slots[slot.index] = slot;
				var row:FieldDeckRow = rows[j];
				if (row.itemsNumChildren == 8) {
					j ++;
					row = rows[j];
				}
				row.addItem(slot);
				slot.position = row.getChildIndex(slot);
			}
		}
		
		public function getSlot (value:int) :FieldDeckSlot {
			return slots[value];
		}
		
		public function clear () :void {
			var row:FieldDeckRow;
			for (var i:int = 0; i < rows.length; i ++) {
				row = rows[i];
				row.clear();
				row.x = -25;
			}
		}
		
		public function reindexSlots () :void {
			var row:FieldDeckRow;
			var slot:FieldDeckSlot;
			slots = {}
			for (var i:int = 0; i < rows.length; i ++) {
				row = rows[i];
				for (var j:int = 0; j < row.numChildren; j ++) {
					slot = row.getChildAt(j) as FieldDeckSlot;
					slot.position = j;
					slot.index = (8 * row.position) + slot.position;
					slots[slot.index] = slot;
				}
			}
		}
		
	}

}