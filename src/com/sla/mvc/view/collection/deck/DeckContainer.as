package com.sla.mvc.view.collection.deck 
{
	import com.sla.mvc.model.data.DeckData;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckContainer extends Sprite 
	{
		private var title:DeckTitle;
		private var stack:Sprite;
		private var newDeckButton:Sprite;
		
		public function DeckContainer(button:Sprite) 
		{
			newDeckButton = button;
			
			var quad:Quad = new Quad(180, 600, 0x444444);
			addChild(quad);
			
			stack = new Sprite ();
			addChild (stack);
			
			title = new DeckTitle('Decklist');
			addChild(title);
			
			stack.y = 51;
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