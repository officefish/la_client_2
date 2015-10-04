package com.sla.mvc.view.field.mana {
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ManaWidget extends Sprite 
	{
		private var bg:Quad;
		
		public function ManaWidget() 
		{
			bg = new Quad(270, 30, 0x0c2735);
			addChild(bg);
						
		}
		
		 public function setMana (value:int, overload:int = 0) :void {
            removeChildren();
			addChild(bg);
			 
			var lamp:Sprite;
			for (var i:int = 0; i < value; i ++) {
                lamp = ManaFabric.getManaItem();
				lamp.x = 16 + 26 * i;
				lamp.y = 15;
				addChild (lamp);
                
            }
			
			var j:int = value + overload;
			
			for (i; i < j; i ++) {
				lamp = ManaFabric.getOveloadItem();
				lamp.x = 16 + 26 * i;
				lamp.y = 15;
				addChild (lamp);
              
			}

            for (j; j < 10; j ++) {
                lamp = ManaFabric.getEmptyItem();
				lamp.x = 16 + 26 * j;
				lamp.y = 15;
				addChild (lamp);
               
            }
        }
		
	}

}