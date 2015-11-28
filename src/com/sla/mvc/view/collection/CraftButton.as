package com.sla.mvc.view.collection 
{
	import com.sla.event.starling.StarlingCraftButtonEvent;
	import feathers.controls.Button;
	import feathers.controls.Label;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftButton extends Sprite 
	{
		private var button:Button;
		private var blockQuad:Quad;
		private var blockFlag:Boolean;
		private var priceLabel:Label;
		
		public function CraftButton(label:String) 
		{
			button = new Button();
			button.styleNameList.add('craftButton');
			button.label = label;
			button.useHandCursor = true;
			button.addEventListener(Event.TRIGGERED, onClick);
			addChild(button);
			
			priceLabel = new Label();
			priceLabel.width = 110;
			priceLabel.height = 40;
			priceLabel.y = 40;
			priceLabel.touchable = false;
			priceLabel.styleNameList.add('craftPriceLabel');
			addChild(priceLabel);
			
			blockQuad = new Quad(110,70,0x222222);
			blockQuad.alpha = 0.7;
		}
		
		private function onClick(event:Event) :void {
			dispatchEvent(new StarlingCraftButtonEvent(StarlingCraftButtonEvent.CLICK));
		}
		
		public function block () :void {
			blockFlag = true;
			addChild (blockQuad);
		} 
		
		public function unblock () :void {
			blockFlag = false;
			if (contains(blockQuad)) removeChild (blockQuad);
		}
		
		public function isBlock () :Boolean {
			return blockFlag;
		}
		
		public function setPrice (value:int) :void {
			priceLabel.text = value.toString();
		}
		
	}

}