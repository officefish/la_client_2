package com.la.mvc.view.achieves 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EmptyAchieveSlot extends Sprite 
	{
		
		private var id:int;
		
		public function EmptyAchieveSlot(id:int) 
		{
			this.id = id;
			graphics.beginFill(0x777777, 1);
			graphics.drawCircle(35,35,35);
			graphics.endFill();
		}
		
		public function getId():int {
			return id;
		}
		
	}

}