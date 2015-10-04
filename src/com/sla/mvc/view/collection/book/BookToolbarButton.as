package com.sla.mvc.view.collection.book 
{
	import com.sla.event.starling.BookToolbarEvent;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BookToolbarButton extends Sprite 
	{
		
		private var activatedItem:Sprite;
		private var deactivatedItem:Sprite;
		
		private var index:int;
		
		public function BookToolbarButton(index:int) 
		{
			this.index = index;
			activatedItem = new Sprite ();
			activatedItem.addChild(new Quad(40, 40, 0xEEEEEE));
			
			deactivatedItem = new Sprite ();
			var deactivatedQuad:Quad =new Quad(30, 30, 0xDDDDDD);
			deactivatedItem.addChild(deactivatedQuad);
			deactivatedItem.x = 5;
			deactivatedItem.y = 10;
			
			this.useHandCursor = true;
						
			addEventListener(TouchEvent.TOUCH, onTouch); 
			
			
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (event.getTouch(this, TouchPhase.BEGAN)) 
			{
				dispatchEvent (new BookToolbarEvent (BookToolbarEvent.CLICK, false, {index:index}));
			}
			
		}
		
		public function activate () :void {
			while (numChildren) removeChildAt (0);
			addChild (activatedItem);
		}
		
		public function deactivate () :void {
			while (numChildren) removeChildAt (0);
			addChild (deactivatedItem);
		}
	}

}