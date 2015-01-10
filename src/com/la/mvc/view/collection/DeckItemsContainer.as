package com.la.mvc.view.collection 
{
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.la.mvc.model.CollectionCardData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckItemsContainer extends Sprite 
	{
		private var stack:Sprite;
		private var cards:Object;
		
		private var itemsCount:int;
		
		private var stackMask:Sprite;
		
		public function DeckItemsContainer() 
		{
			graphics.beginFill (0x444444);
			graphics.drawRect (0, 0, 180, 500);
			graphics.endFill();
			
			stack = new Sprite ();
			addChild (stack);
			
			stackMask = new Sprite ();
			stackMask.graphics.beginFill (0xEEEEEE, 0.5);
			stackMask.graphics.drawRect (0, 0, 180, 500);
			stackMask.graphics.endFill();
			addChild (stackMask)
			
			stack.mask = stackMask;
			
			stackMask.mouseEnabled = false;
			
			cards = { };
			
			itemsCount = 0;
			
			this.addEventListener (MouseEvent.MOUSE_WHEEL, onSlotMouseWheel);
		}
		
		public function defaultStack () :void {
			stack.y = 0;
		}
		
		public function clear () :void {
			while (stack.numChildren) stack.removeChildAt (0);
			cards = { };
			itemsCount = 0;
		}
		
		public function addDeckItem (data:CollectionCardData) :void {
			if (cards[data.getId()] == 	null) {
				slot = new DeckItemSlot (data, true);
				slot.x = 5;
				cards[data.getId()] = slot;
				slot.addEventListener (MouseEvent.MOUSE_WHEEL, onSlotMouseWheel);
				stack.addChild (slot);
				sortStack();
			} else {
				var slot:DeckItemSlot = cards[data.getId()];
				slot.increment();
			}
			itemsCount ++;
			if (stack.height > stackMask.height) {
				stack.y = (stackMask.height - stack.height) - 10;
			}
		}
		
		public function removeDeckItem (data:CollectionCardData) :void {
			var slot:DeckItemSlot = cards[data.getId()] as DeckItemSlot;
			slot.decrement();
			if (!slot.getCount()) {
				stack.removeChild(slot);
				slot.removeEventListener (MouseEvent.MOUSE_WHEEL, onSlotMouseWheel);
				cards[data.getId()] = null;
				sortStack();
			}
			itemsCount --;
		}
		
		public function getDeckItems () :Array {
			var list:Array = [];
			for (var i:int = 0; i < stack.numChildren; i ++) {
				list.push (stack.getChildAt(i))
			}
			return list;
		}
		
		public function getCount () :int {
			return itemsCount;
		}
		
		private function sortStack () :void {
			var slots:Array = [];
			var i:int;
			var slot:DeckItemSlot;
			for (i = 0; i < stack.numChildren; i++) {
				slot = stack.getChildAt(i) as DeckItemSlot;
				slots.push (slot);
			}
			
			slots.sort (sortByPrice);
			
			var shiftY:int = 5;
			for (i = 0; i < slots.length; i ++) {
				slot = slots[i] as DeckItemSlot;
				stack.addChild (slot);
				slot.y = shiftY + (slot.height + 1) * i;
			}
			
		}
		
		private function sortByPrice (a, b) :int {
		   var x1:int = a.price;
		   var x2:int = b.price;
		   if (x1 < x2)
		   {
				return -1;
		   }
		   else if (x1 > x2)
		   {
				return 1;
		   }
		   else
		   {
				return 0;
		   }
		}
		
		private function onSlotMouseWheel (event:MouseEvent) :void {
			if (stack.height <= stackMask.height) {
				return;
			}
			
			var index:int;
			var maxShift:int = (stackMask.height - stack.height) - 10;
			if (event.delta > 0) {
				index = stack.y;
				index += (7.5 * event.delta);
				if (index <= 0) {
					TweenLite.to (stack, 0.4, { y:index, ease:Expo.easeOut }) ;
				} else {
					index = 0;
					TweenLite.to (stack, 0.4, { y:index, ease:Expo.easeOut }) ;

				}
			} else {
				index = stack.y;
				index += (7.5 * event.delta);
				if (index > maxShift) {
					TweenLite.to (stack, 0.4, { y:index, ease:Expo.easeOut }) ;
				} else {
					index = maxShift;
					TweenLite.to (stack, 0.4, { y:index, ease:Expo.easeOut }) ;

				}
			}
		}
		
	}

}