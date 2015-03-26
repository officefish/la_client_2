package com.la.mvc.view.collection 
{
	import com.la.mvc.view.ui.SmallButton;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftBar extends Sprite 
	{
		
		private var title:DeckTitle;
		private var readyButton:SmallButton;
		private var dustCounter:DustCounter;
		
		public function CraftBar() 
		{
			super();
			graphics.beginFill (0x444444);
			graphics.drawRect (0, 0, 180, 600);
			graphics.endFill();
			
			title = new DeckTitle ('Создание карт');
			addChild (title);
			
			readyButton = new SmallButton ('Готово', 140, 35);
			addChild (readyButton);
			readyButton.x = 20;
			readyButton.y = 550;
			
			dustCounter = new DustCounter ();
			dustCounter.x = 20;
			dustCounter.y = 460;
			addChild (dustCounter);
					
		}
		
		public function getReadyButton () :Sprite {
			return readyButton;
		}
		
		public function setDust (value:int) :void {
			dustCounter.setDust (value);
		}
		
	}

}