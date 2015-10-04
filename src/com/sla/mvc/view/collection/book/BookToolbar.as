package com.sla.mvc.view.collection.book 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.starling.BookToolbarEvent;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class BookToolbar extends Sprite 
	{
		
		public function BookToolbar(count:int) 
		{
			var button:BookToolbarButton
			for (var i:int = 0; i < count; i ++) {
				button = new BookToolbarButton (i);
				button.x = 41 * i;
				button.deactivate();
				button.addEventListener (BookToolbarEvent.CLICK, onClick);
				addChild (button);
			}
		}
		
		public function destroy() :void {
			var button:BookToolbarButton; 
			while (numChildren) {
				button =  this.getChildAt(0) as BookToolbarButton;
				button.removeEventListener (BookToolbarEvent.CLICK, onClick);
				removeChild(button);
			}
		}
		
		
		private function onClick (event:BookToolbarEvent) :void {
			//MonsterDebugger.log('BookToolbarEvent');
			dispatchEvent (event);
		}
		
		
		public function activate (index:int) :void {
			var item:BookToolbarButton;
			for (var i:int = 0; i < numChildren; i ++) {
				item =  this.getChildAt(i) as BookToolbarButton;
				item.deactivate();
			}
			item =  this.getChildAt(index) as BookToolbarButton;
			item.activate();			
		}
	}

}