package com.la.mvc.view.achieves 
{
	import com.la.mvc.view.card.AchieveCard;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchievePage extends Sprite 
	{
		
		private var cardsStack:Sprite;
		private var shiftX:int = 20;
		private var shiftY:int = 60;
		
		public function AchievePage() 
		{
			graphics.beginFill(0x888888, 1);
			graphics.drawRect(0,0,620,480);
			graphics.endFill();	
			
			cardsStack = new Sprite();
			addChild(cardsStack);
		}
		
		public function get cardsCount () :int {
			return cardsStack.numChildren;
		}
		
		public function addCard (card:Sprite):void {
			card.x = shiftX;
			card.y = shiftY;
			cardsStack.addChild (card);
			shiftX += (card.width + 15);
			if (cardsStack.numChildren == 4) {
				shiftX = 20;
				shiftY += 10 + card.height;
			}
		}
		
	}

}