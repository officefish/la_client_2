package com.la.mvc.view.collection 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BooksToolbarButon extends Sprite 
	{
		
		private var activatedItem:Sprite;
		private var deactivatedItem:Sprite;
		
		private var index:int;
		
		public function BooksToolbarButon(index:int) 
		{
			this.index = index;
			activatedItem = new Sprite ();
			activatedItem.graphics.beginFill (0xEEEEEE);
			activatedItem.graphics.drawRect (0, 0, 40, 40);
			activatedItem.graphics.endFill();
			
			deactivatedItem = new Sprite ();
			deactivatedItem.graphics.beginFill (0xDDDDDD);
			deactivatedItem.graphics.drawRect (0, 0, 30, 30);
			deactivatedItem.graphics.endFill();
			deactivatedItem.x = 5;
			deactivatedItem.buttonMode = true;
			deactivatedItem.y = 10;
			deactivatedItem.addEventListener (MouseEvent.CLICK, onClick);
			
			
		}
		
		private function onClick (event:MouseEvent) :void {
			dispatchEvent (new ToolbarButtonEvent (ToolbarButtonEvent.CLICK, index));
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