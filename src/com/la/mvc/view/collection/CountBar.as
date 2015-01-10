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
	public class CountBar extends Sprite
	{
		
		private var closeButton:Sprite;
		private var saveButton:Sprite;
		private var countLabel:TextField;
		private var typeLabel:TextField;
		
		private var count:int = 0;
		
		private static const MAX_DECKS:int = 9;
		private static const DECKS:String = 'Колоды';
		
		private static const MAX_CARDS:int = 30;
		private static const CARDS:String = 'Карты';
		
		private var mode:int;
		
		public function CountBar() 
		{
			graphics.beginFill (0xEEEEEE, 1);
			graphics.drawRect (0, 0, 180, 50);
			graphics.endFill ();
			
			closeButton = new CountBarButton ('Закрыть');
			closeButton.x = 105;
			closeButton.y = (this.height - closeButton.height) / 2;
			addChild (closeButton);
			
			saveButton = new CountBarButton ('Готово');
			saveButton.x = 105;
			saveButton.y = (this.height - saveButton.height) / 2;
			addChild (saveButton);
			
			var format:TextFormat = new TextFormat();
			format.color = 0x222222;
			format.size = 14;
			format.bold = true;
			format.align = TextFormatAlign.CENTER;
			
			countLabel = new TextField ();
			countLabel.defaultTextFormat = format;
			countLabel.mouseEnabled = false;
			countLabel.width = 105;
			countLabel.height = 20;
			countLabel.text = count + '/' + MAX_DECKS;
			addChild (countLabel);
			countLabel.y = 8;
			
			typeLabel = new TextField ();
			typeLabel.defaultTextFormat = format;
			typeLabel.mouseEnabled = false;
			typeLabel.width = 105;
			typeLabel.height = 20;
			typeLabel.text = DECKS;
			typeLabel.y = 25;
			addChild (typeLabel);
		}
		
		public function setMode (mode:int) :void {
			if (contains(saveButton)) removeChild (saveButton);
			if (contains(closeButton)) removeChild (closeButton);
			
			this.mode = mode;
			if (mode) {
				addChild (saveButton);
			} else {
				addChild (closeButton);
			}
		}
		
		public function setCount (value:int) :void {
			this.count = value;
			if (mode) {
				countLabel.text = count + '/' + MAX_CARDS;
				typeLabel.text = CARDS;
			} else {
				countLabel.text = count + '/' + MAX_DECKS;
				typeLabel.text = DECKS;
			}
		}
		
		public function getCloseButton () :Sprite {
			return closeButton;
		}
		
		public function getSaveButton () :Sprite {
			return saveButton;
		}
		
	}

}