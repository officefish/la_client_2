package com.la.mvc.view.collection 
{
	import com.la.mvc.model.DeckData;
	import com.la.mvc.view.mediator.DeckItemSlotMediator;
	import com.la.mvc.view.collection.DeckSlot;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DecksContainer extends Sprite 
	{
		private var title:DeckTitle;
		private var stack:Sprite;
		
		private var newDeckButton:NewDeckButton
		
		public function DecksContainer(newDeckButton:NewDeckButton) 
		{
			this.newDeckButton = newDeckButton;
			
			graphics.beginFill (0x444444);
			graphics.drawRect (0, 0, 180, 600);
			graphics.endFill();
			
			title = new DeckTitle ();
			addChild (title);
			
			stack = new Sprite ();
			addChild (stack);
			stack.y = title.height + 1;
			
		} 
		
		public function clear () :void {
			while (stack.numChildren) stack.removeChildAt(0);
			newDeckButton.y = 0;
			stack.addChild (newDeckButton);

		}
		
		public function addDeck (data:DeckData) :void {
			var slot:DeckSlot = new DeckSlot (data); 
			stack.addChild (slot);
			sortStack();
		}
		
		private function sortStack () :void {
			if (stack.contains(newDeckButton)) stack.removeChild (newDeckButton);
			var shiftY:int = 1;
			for (var i:int = 0; i < stack.numChildren; i ++) {
				var item:Sprite = stack.getChildAt(i) as Sprite;
				item.y = shiftY;
				shiftY += item.height + 1;
			}
			if (stack.numChildren < 9) {
				newDeckButton.y = shiftY;
				stack.addChild (newDeckButton);
			}
			
		}
		
		
	}

}