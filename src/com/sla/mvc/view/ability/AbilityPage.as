package com.sla.mvc.view.ability 
{
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityPage extends Sprite 
	{
		private var stack:Sprite;
		private var shiftX:int = 15;
		private var shiftY:int = 60;
		
		public function AbilityPage() 
		{
			var quad:Quad = new Quad(620, 480, 0x888888);
			addChild(quad);
			
			stack = new Sprite();
			addChild(stack);
		}
		
			public function get cardsCount () :int {
			return stack.numChildren;
		}
		
		public function addCard (card:Sprite):void {
			card.x = shiftX + AbilityCard.CARD_WIDTH/2; 
			card.y = shiftY + AbilityCard.CARD_HEIGHT/2;
			stack.addChild (card);
			shiftX += (AbilityCard.CARD_WIDTH + 15);
			if (stack.numChildren == 4) {
				shiftX = 15;
				shiftY += 25 + AbilityCard.CARD_HEIGHT;
			}
		}
		
		
		
	}

}