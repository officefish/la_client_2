package com.la.mvc.view.intro 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class IntroMenu extends Sprite 
	{
		
		public function IntroMenu(items:Array) :void 
		{
			var item:Sprite;
			for (var i:int = 0; i < items.length; i ++) {
				item = getMenuItem(items[i]) 
				addChild (item);
				item.y = 40 * i + i;
			}
		}
		
		private function getMenuItem (label:String) :Sprite {
			var item:Sprite = new Sprite();
			item.graphics.beginFill (0xFFFFFF, 1);
			item.graphics.drawRect (0, 0, 180, 40);
			item.graphics.endFill();
			item.buttonMode = true;

			
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.bold = true;
			format.size = 15;
			
			var tf:TextField = new TextField();
			tf.defaultTextFormat = format;
			tf.text = label;
			tf.width = 180;
			tf.height = 30;
			tf.mouseEnabled = false;
			
			item.addChild(tf);
			tf.y = 10;
			
			return item;
			
		}
		
		
		
	}

}