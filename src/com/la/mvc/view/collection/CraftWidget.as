package com.la.mvc.view.collection 
{
	import com.la.event.CollectionEvent;
	import com.la.mvc.view.ui.CraftButton;
	import com.la.mvc.view.ui.SmallButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftWidget extends Sprite 
	{
		
		private var state:int;
		
		private var craftBtn:CraftButton;
		private var destroyBtn:CraftButton;
		private var noCraftLabel:TextField;
		
		public function CraftWidget() 
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
			
			var format:TextFormat = new TextFormat ();
			format.bold = true;
			format.size = 14;
			format.align = TextFormatAlign.CENTER;
			
			noCraftLabel = new TextField ();
			noCraftLabel.mouseEnabled = false;
			noCraftLabel.width = this.width;
			noCraftLabel.height = 30;
			noCraftLabel.defaultTextFormat = format;
			noCraftLabel.y = 30;
			noCraftLabel.text = 'Эту карту нельзя распылять';
		}
		
		public function setState (state:int) :void {
			while (this.numChildren) removeChildAt (0);
			craftBtn.unblock();
			destroyBtn.unblock();
			if (state) {
				addChild (craftBtn);
				addChild (destroyBtn);
			} else {
				addChild(noCraftLabel);
			}
			this.state = state;
		}
		
		public function getState () :int {
			return state;
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
		
		public function onCraftClick (event:MouseEvent) :void {
			if (craftBtn.isBlock()) return;
			dispatchEvent (new CollectionEvent (CollectionEvent.CRAFT_CARD));
		}
		
		public function onDestroyClick (event:MouseEvent) :void {
			if (destroyBtn.isBlock()) return;
			dispatchEvent (new CollectionEvent(CollectionEvent.DESTROY_CARD));
		}
	}

}