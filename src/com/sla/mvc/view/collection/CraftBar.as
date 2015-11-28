package com.sla.mvc.view.collection 
{
	import com.sla.mvc.view.collection.deck.DeckTitle;
	import starling.display.Quad;
	import starling.display.Sprite;
	import feathers.controls.Button;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftBar extends Sprite 
	{
		private var title:DeckTitle;
		private var dustCounter:DustCounter;
		
		public function CraftBar(label:String, readyButton:Button) 
		{
			var quad:Quad = new Quad(180, 600, 0x4444444);
			addChild(quad);
			
			title = new DeckTitle(label);
			addChild(title);
			
			dustCounter = new DustCounter ();
			dustCounter.x = 20;
			dustCounter.y = 460;
			addChild (dustCounter);
			
			readyButton.x = 90;
			readyButton.y = 550;
			addChild(readyButton);
		}
		public function setDust (value:int) :void {
			dustCounter.setDust (value);
		}
		
	}

}