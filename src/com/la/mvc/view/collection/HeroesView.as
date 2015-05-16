package com.la.mvc.view.collection 
{
	import com.la.event.CollectionEvent;
	import com.la.event.HeroesViewEvent;
	import com.la.mvc.model.HeroData;
	import com.la.mvc.view.deck.DeckHeroWidget;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroesView extends Sprite 
	{
		
		private var actualSlot:HeroSlot;
	    private var widget:DeckHeroWidget; 
		private var selectHeroButton:SelectHeroButton;

		
		public function HeroesView() 
		{
			graphics.beginFill(0xCCCCCC, 1);
			graphics.drawRect(0,0,800,600);
			graphics.endFill();	
			
			graphics.beginFill(0x444444, 1);
			graphics.drawRect(600,0,200,600);
			graphics.endFill();	
			
			widget = new DeckHeroWidget ();
			selectHeroButton = new SelectHeroButton ();
		}
		
		public function initHeroes (heroes:Array) :void {
			var data:HeroData;
			var slot:HeroSlot;
			
			var shiftX:int = 50; 
			var shiftY:int = 50;
			var spaceIndex:int = 0;
			
			for (var i:int = 0; i < heroes.length; i ++) {
				data = heroes[i] as HeroData;
				slot = new HeroSlot (data);
				slot.addEventListener (MouseEvent.CLICK, onSlotClick);
				slot.x = shiftX;
				slot.y = shiftY;
				shiftX += (100 + slot.width);
				spaceIndex ++;
				if (spaceIndex > 3) {
					shiftX = 50;
					shiftY += 100;
					spaceIndex = 0;
				}
				addChild (slot);
			}
		}
		
		private function onSlotClick (event:MouseEvent) :void {
			var slot:HeroSlot = event.target as HeroSlot;
			if (actualSlot) {
				actualSlot.stopGlow ();
			}
			actualSlot = slot;
			actualSlot.glow();
			
			if (!contains(widget)) {
				addChild (widget);
				widget.x = 600;
				widget.y = 140;
			}
			
			if (!contains(selectHeroButton)) {
				addChild (selectHeroButton);
				selectHeroButton.x = 610;
				selectHeroButton.y = 510;
				selectHeroButton.addEventListener (MouseEvent.CLICK, onSelectHero);
			}
			widget.setHeroData (actualSlot.getData());
		}
		
		private function onSelectHero (event:MouseEvent) :void {
			var heroId:int = actualSlot.getData().id;
			dispatchEvent (new HeroesViewEvent(HeroesViewEvent.SELECT, heroId));
		}
		
	}

}