package com.la.mvc.view.collection 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class RemoveDeckBtn extends Sprite 
	{
		
		private var maskSprite:Sprite;
		
		public function RemoveDeckBtn() 
		{
			graphics.clear ();
			graphics.lineStyle (7, 0xFF8888, 1);
			graphics.lineTo (20, 20);
			graphics.moveTo (0, 20);
			graphics.lineTo (20, 0);
			
			maskSprite = new Sprite ();
			maskSprite.graphics.beginFill (0xFF0000, 0.2);
			maskSprite.graphics.drawCircle (10, 10, 10);
			maskSprite.graphics.endFill();
			addChild (maskSprite);
			
			this.mask = maskSprite;
			
			addEventListener (MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener (MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			graphics.clear ();
			graphics.lineStyle (7, 0xFF0000, 1);
			graphics.lineTo (20, 20);
			graphics.moveTo (0, 20);
			graphics.lineTo (20, 0);
			
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			graphics.clear ();
			graphics.lineStyle (7, 0xFF8888, 1);
			graphics.lineTo (20, 20);
			graphics.moveTo (0, 20);
			graphics.lineTo (20, 0);
		}
		
	}

}