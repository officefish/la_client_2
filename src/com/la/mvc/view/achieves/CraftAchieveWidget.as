package com.la.mvc.view.achieves 
{
	import com.la.event.AchieveEvent;
	import com.la.mvc.view.ui.CraftButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftAchieveWidget extends Sprite 
	{
		private var state:int;
		
		private var craftBtn:CraftButton;
		private var destroyBtn:CraftButton;
		private var achieveId:int;
		
		public function CraftAchieveWidget() 
		{
			graphics.beginFill (0xDDDDDD, 1);
			graphics.drawRect (0,0,246,80);
			graphics.endFill ();
			
			craftBtn = new CraftButton ('Создать', 110, 70);
			craftBtn.x = (this.width / 2) + (this.width / 2 - craftBtn.width) / 2;
			craftBtn.y = 5;
			craftBtn.addEventListener (MouseEvent.CLICK, onCraftClick)
			
			destroyBtn = new CraftButton ('Распылить', 110, 70);
			destroyBtn.x = (this.width / 2 - destroyBtn.width) / 2;
			destroyBtn.y = 5;
			destroyBtn.addEventListener(MouseEvent.CLICK, onDestroyClick);
			
			addChild (craftBtn);
			addChild (destroyBtn);
						
		}
		
		public function setAchieveId (achieveId:int) :void {
			this.achieveId = achieveId
		}
		
		private function onCraftClick (event:MouseEvent) :void {
			dispatchEvent (new AchieveEvent (AchieveEvent.CRAFT, {achieveId:achieveId}))
		}
		
		private function onDestroyClick (event:MouseEvent) :void {
			dispatchEvent (new AchieveEvent (AchieveEvent.DESTROY, {achieveId:achieveId}))
		}
		
		public function unblock () :void {
			craftBtn.defaultState();
			destroyBtn.defaultState();
			craftBtn.unblock();
			destroyBtn.unblock();
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