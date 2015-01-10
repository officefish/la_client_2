package com.la.mvc.view.intro 
{
	import com.la.event.IntroEvent;
	import com.la.mvc.view.IIntro;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Intro extends Sprite implements IIntro
	{
		
		private var menu:IntroMenu;
		
		public function Intro() 
		{
			//graphics.beginFill (0xFFFFFF, 1);
			//graphics.drawRect (0, 0, 300, 300);
			//graphics.endFill();
			//addEventListener (MouseEvent.CLICK, onClick);
			
			menu = new IntroMenu (['В бой', 'Коллекция']);
			menu.addEventListener (MouseEvent.CLICK, onClick, true);
			addChild (menu);
			
		}
		
		private function onClick (event:MouseEvent) :void {
			switch (event.target.parent.getChildIndex(event.target)) {
				case 0: {
					dispatchEvent(new IntroEvent(IntroEvent.SELECT_GAME)); 
					break;
				}
				case 1: {
					dispatchEvent(new IntroEvent(IntroEvent.SELECT_COLLECTION)); 
					break;
				}
			}
			dispatchEvent(new IntroEvent(IntroEvent.COMPLETE));
		}
		
		public function destroy () :void {
			
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			menu.x = (stageWidth - menu.width) / 2;
			menu.y = (stageHeight - menu.height) / 3;
		}
	}

}