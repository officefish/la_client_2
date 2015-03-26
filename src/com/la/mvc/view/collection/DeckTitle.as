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
		
		private var _label:TextField;
		
		public function DeckTitle(label:String = 'Мои колоды') 
		{
			graphics.beginFill (0x222222);
			graphics.drawRect (0, 0, 180, 50);
			graphics.endFill ();
			
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.color = 0xEEEEEE;
			format.size = 14;
			format.bold = true;
			
			_label = new TextField ();
			_label.defaultTextFormat = format;
			_label.width = this.width;
			_label.mouseEnabled = false;
			_label.y = 15;
			_label.height = 20;
			_label.text = label
			addChild(_label)
		}
		
	}

}