package com.la.mvc.view.collection 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SelectHeroButton extends Sprite 
	{
		private var label:TextField;
		
		public function SelectHeroButton() 
		{
			graphics.beginFill (0x56A5EC);
			graphics.drawRect (0, 0, 180, 50);
			graphics.endFill (); 
			
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.color = 0xEEEEEE;
			format.size = 14;
			format.bold = true;
			
			label = new TextField ();
			label.defaultTextFormat = format;
			label.width = this.width;
			label.mouseEnabled = false;
			label.y = 15;
			label.height = 20;
			label.text = 'Выбрать героя';
			addChild(label)
			
			buttonMode = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			graphics.clear();
			graphics.beginFill (0x82CAFA);
			graphics.drawRect (0, 0, 180, 50);
			graphics.endFill ();
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			graphics.clear();
			graphics.beginFill (0x56A5EC);
			graphics.drawRect (0, 0, 180, 50);
			graphics.endFill ();
		}
		
	}

}