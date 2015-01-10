package com.la.mvc.view.collection 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BooksToolbar extends Sprite 
	{
		
		public function BooksToolbar(count:int) 
		{
			var button:BooksToolbarButon
			for (var i:int = 0; i < count; i ++) {
				button = new BooksToolbarButon (i);
				button.x = 41 * i;
				button.deactivate();
				button.addEventListener (ToolbarButtonEvent.CLICK, onClick);
				addChild (button);
			}
		}
		
		public function destroy() :void {
			var button:BooksToolbarButon;
			while (numChildren) {
				button =  this.getChildAt(0) as BooksToolbarButon;
				button.removeEventListener (ToolbarButtonEvent.CLICK, onClick);
				removeChild(button);
			}
		}
		
		private function onClick (event:ToolbarButtonEvent) :void {
			dispatchEvent (event);
		}
		
		public function activate (index:int) :void {
			var item:BooksToolbarButon;
			for (var i:int = 0; i < numChildren; i ++) {
				item =  this.getChildAt(i) as BooksToolbarButon;
				item.deactivate();
			}
			item =  this.getChildAt(index) as BooksToolbarButon;
			item.activate();			
		}
		
	}

}