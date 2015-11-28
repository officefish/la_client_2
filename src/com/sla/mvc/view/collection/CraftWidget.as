package com.sla.mvc.view.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.starling.StarlingCraftButtonEvent;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftWidget extends Sprite 
	{
		
		private var craftBtn:CraftButton;
		private var destroyBtn:CraftButton;
		private var state:int;
		private var bg:Quad;
		
		public function CraftWidget() 
		{
			bg = new Quad(244,80,0xDDDDDD);
			addChild(bg);
			
			craftBtn = new CraftButton ('Craft');
			craftBtn.x = (244 / 2) + (244 / 2 - 110) / 2;
			craftBtn.y = 5;
			craftBtn.addEventListener (StarlingCraftButtonEvent.CLICK, onCraftClick)
			
			destroyBtn = new CraftButton ('Dust');
			destroyBtn.x = (244 / 2 - 110) / 2;
			destroyBtn.y = 5;
			destroyBtn.addEventListener(StarlingCraftButtonEvent.CLICK, onDestroyClick);
		}
		
		private function onCraftClick(event:StarlingCraftButtonEvent) :void {
			dispatchEvent(new StarlingCraftButtonEvent(StarlingCraftButtonEvent.CRAFT));
		}
		
		private function onDestroyClick(event:StarlingCraftButtonEvent) :void {
			dispatchEvent(new StarlingCraftButtonEvent(StarlingCraftButtonEvent.DESTROY));
		}
		
		public function setState (state:int) :void {
			this.removeChildren();
			addChild(bg);
			craftBtn.unblock();
			destroyBtn.unblock();
			if (state) {
				addChild (craftBtn);
				addChild (destroyBtn);
			} else {
				//addChild(noCraftLabel);
			}
			this.state = state;
		}
		
		public function setPrices (craftPrice:int, destroyPrice:int) :void {
			craftBtn.setPrice (craftPrice);
			destroyBtn.setPrice (destroyPrice);
		}
		
		public function blockCraftButton () :void {
			craftBtn.block();
		}
		
		public function blockDestroyButton () :void {
			destroyBtn.block();
		}
		
	}

}