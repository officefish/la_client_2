package com.sla.mvc.view.field 
{
	import starling.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import starling.display.Image;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PopupButton extends Sprite 
	{
		private var manacostTxt:TextField;
		public function PopupButton(label:String) 
		{
			this.useHandCursor = true;
			
			var s2:flash.display.Shape = new flash.display.Shape();
			s2.graphics.beginFill(0xEEEEEE, 1);
			s2.graphics.drawCircle(30,30,30);
			s2.graphics.endFill();

			var bmpData:BitmapData = new BitmapData(60,60,true,0x00FFFFFF);
			bmpData.draw(s2);

			var bmp:Image = Image.fromBitmap(new Bitmap(bmpData, "auto", true));
			bmp.x -= 30;
			bmp.y -= 30;
			addChild(bmp);
			
			var txt:TextField = new TextField(60, 20, label, 'Verdana', 10, 0x0, false);
			addChild(txt);
			txt.touchable = false;
			txt.x -= 30;
			txt.y -= 10;
			txt.hAlign = HAlign.CENTER;
			
			this.addEventListener(TouchEvent.TOUCH, onTouch)
		
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (event.getTouch(this, TouchPhase.HOVER)) {
				glow();
			} else {
				stopGlow();
			}
		}
		
		public function set manacost (value:int) :void {
			if (manacostTxt == null) {
				manacostTxt = new TextField(60, 20, '', 'Verdana', 10, 0x0, true);
				manacostTxt.hAlign = HAlign.CENTER;
				manacostTxt.x -= 30;
				manacostTxt.touchable = false;
				addChild(manacostTxt);
			}
			manacostTxt.text = "(" + value.toString() +")";
		}
		
		private static var _glowWilter:BlurFilter; 
		private static function get glowFilter () :BlurFilter {
			if (!_glowWilter) {
				_glowWilter = BlurFilter.createGlow(0x00FFFF, 1, 3, .5);
			}
			return _glowWilter; 
		}
		
		public function glow () :void {
			this.filter = glowFilter;
		}
		
		public function stopGlow () :void {
			this.filter = null;
		}
		
	}

}