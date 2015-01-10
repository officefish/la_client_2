package com.la.mvc.view.collection 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckTitle extends Sprite 
	{
		
		private var label:TextField;
		
		public function DeckTitle() 
		{
			graphics.beginFill (0x222222);
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
			label.text = 'Мои колоды';
			addChild(label)
		}
		
	}

}