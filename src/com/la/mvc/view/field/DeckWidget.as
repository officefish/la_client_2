package com.la.mvc.view.field 
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckWidget extends Sprite 
	{
		
		private var cardsCountLabel:TextField;
		
		public function DeckWidget() 
		{
			cardsCountLabel = new TextField();
			cardsCountLabel.antiAliasType = AntiAliasType.ADVANCED;
			cardsCountLabel.defaultTextFormat = DeckWidget.countFormat;
			cardsCountLabel.mouseEnabled = false;
			cardsCountLabel.width = 100;
			cardsCountLabel.height = 30;
			addChild(cardsCountLabel);
		}
		
		public function clear () :void {
			cardsCountLabel.text = '';
		}
		
		public function setCount(value:int) :void {
			cardsCountLabel.text = value.toString() + ' карт' + DeckWidget.getEnding(value);
		}
		
		private static var _countFormat:TextFormat;
		private static function get countFormat () :TextFormat {
			if (!_countFormat) {
				_countFormat = new TextFormat();
				_countFormat.align = TextFormatAlign.CENTER;
				_countFormat.color = 0x777777;
				_countFormat.size = 12;
				_countFormat.bold = true;
			} 
			return _countFormat;
		}
		
		private static function getEnding(value:int) :String {
			switch (value) {
				case 1:
				case 21:
				case 31:
				case 41: {
					return 'a';
				}
				case 2:
				case 3:
				case 4:
				case 22:
				case 23:
				case 24:
				case 32:
				case 33:
				case 34:
				{
					return 'ы'
				}
				default: {
					return ''
				}
					
			}
		}
		
	}

}