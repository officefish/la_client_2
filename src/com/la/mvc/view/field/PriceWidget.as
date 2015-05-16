package com.la.mvc.view.field
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author 
	 */
	public class PriceWidget extends Sprite
	{

        public function PriceWidget()
        {
            graphics.beginFill (0x777777, 1);
            graphics.drawRect (0, 0, 210, 30);
            graphics.endFill ();

            for (var i:int = 0; i < 10; i ++) {
                var lamp:Sprite = new Sprite ();
                lamp.graphics.beginFill (0x555555, 1);
                lamp.graphics.drawRect (0, 0, 16, 16);
                lamp.graphics.endFill ();
                lamp.x = this.numChildren * 13 + (7 * (numChildren + 1));
                lamp.y = 7;
                addChild (lamp);
            }
        }
		
		public function clear() :void {
			setPrice(0);
		}

        public function setPrice (value:int, overload:int = 0) :void {
            var lamp:Sprite;
			for (var i:int = 0; i < value; i ++) {
                lamp = getChildAt (i) as Sprite;
				if (lamp) {
					lamp.graphics.clear ();
					lamp.graphics.beginFill (0x00FFFF, 1);
					lamp.graphics.drawRect (0, 0, 16, 16);
					lamp.graphics.endFill ();
				}
                
            }
			
			var j:int = value + overload;
			
			for (i; i < j; i ++) {
				lamp = getChildAt (i) as Sprite;
				if (lamp) {
					lamp.graphics.clear ();
					lamp.graphics.beginFill (0x7D0552, 1);
					lamp.graphics.drawRect (0, 0, 16, 16);
					lamp.graphics.endFill ();
				}
              
			}

            for (j; j < 10; j ++) {
                lamp = getChildAt (j) as Sprite;
				if (lamp) {
					lamp.graphics.clear ();
					lamp.graphics.beginFill (0x555555, 1);
					lamp.graphics.drawRect (0, 0, 16, 16);
					lamp.graphics.endFill ();
				}
               
            }
        }
		
		
	}

}