package com.la.mvc.view.field 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveRadio extends Sprite 
	{
		
		public function AchieveRadio() 
		{
			graphics.beginFill(0x222222, 1);
			graphics.drawCircle(2,2,2);
			graphics.endFill();	
		}
		
		public function enable () :void {
			graphics.clear();
			graphics.beginFill(0x00FFFF, 1);
			graphics.drawCircle(2,2,2);
			graphics.endFill();	
		}
		
		public function disable () :void {
			graphics.clear();
			graphics.beginFill(0x222222, 1);
			graphics.drawCircle(2,2,2);
			graphics.endFill();	
		}
		
	}

}