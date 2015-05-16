package com.la.mvc.view.field 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class OverloadWidget extends Sprite 
	{
		
		public function OverloadWidget() 
		{
			for (var i:int = 0; i < 10; i ++) {
                var lamp:Sprite = new Sprite ();
                lamp.graphics.beginFill (0x7D0552, 1);
                lamp.graphics.drawRect (0, 0, 16, 16);
                lamp.graphics.endFill ();
                lamp.x = this.numChildren * 13 + (7 * (numChildren + 1));
                lamp.y = 7;
				lamp.visible = false;
                addChild (lamp);
            }			
		}
		
		public function drawOwerload (price:int, overloard:int) :void {
			var startIndex:int = price - overloard;
			var lamb:Sprite;
			for (var i:int = startIndex; i < price; i++) {
				try {
					lamb = this.getChildAt(i) as Sprite;
					lamb.visible = true;
				} catch (e:Error) {
					break;
				} 
			}
		}
		
		public function clear () :void {
			var lamb:Sprite;
			for (var i:int = 0; i < this.numChildren; i ++) {
				lamb = this.getChildAt(i) as Sprite;
				lamb.visible = false;
			}
		}
		
		
		
	}

}