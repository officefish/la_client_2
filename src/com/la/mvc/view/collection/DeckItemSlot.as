package com.la.mvc.view.collection 
{
	import com.la.mvc.model.CollectionCardData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckItemSlot extends Sprite 
	{
		
		private var priceLabel:TextField;
		private var titleLabel:TextField;
		private var countLabel:TextField;
		private var count:int = 1;
		private var data:CollectionCardData;
		
		public function DeckItemSlot(data:CollectionCardData, countFlag:Boolean = false) 
		{
			this.data = data;
			
			graphics.beginFill(0xCCCCCC, 1);
			graphics.drawRect (0, 0, 170, 30);
			graphics.endFill();
			
			graphics.lineStyle (1, 0, 1);
			graphics.lineTo (width-1, 1);
			graphics.lineTo (width-1, height-1);
			graphics.lineTo(1, height-1);
			graphics.lineTo (1, 1);
			
			graphics.beginFill(0xFFFFFF, 1);
			graphics.drawRect (0, 0, 29, 29);
			graphics.endFill();
			
			graphics.moveTo (29, 0);
			graphics.lineTo (29, 29);
			
			priceLabel = new TextField ();
			priceLabel.width = 30;
			priceLabel.y = 3;
			priceLabel.height = 20; 
			priceLabel.mouseEnabled = false;
			priceLabel.defaultTextFormat = DeckItemSlot.priceFormat;
			priceLabel.text = data.getPrice().toString();
			addChild (priceLabel);
			
			titleLabel = new TextField ();
			titleLabel.width = 110;
			titleLabel.x = 35;
			titleLabel.y = 5;
			titleLabel.height = 20;
			titleLabel.mouseEnabled = false;
			titleLabel.defaultTextFormat = DeckItemSlot.titleFornmat;
			titleLabel.text = data.getTitle();
			addChild (titleLabel);
			
			if (countFlag) {
				countLabel = new TextField ();
				countLabel.width = 20;
				countLabel.x = (this.width - countLabel.width);
				countLabel.y = 5;
				countLabel.height = 20;
				countLabel.mouseEnabled = false;
				countLabel.defaultTextFormat = DeckItemSlot.countFornmat;
				countLabel.text = count.toString();
				addChild (countLabel);
				if (count > 1) {
					countLabel.visible = true;
				} else {
					countLabel.visible = false;
				}
			}
		}
		
		private static var _priceFormat:TextFormat;
		private static function get priceFormat () :TextFormat {
			if (!_priceFormat) {
				_priceFormat = new TextFormat();
				_priceFormat.align = TextFormatAlign.CENTER;
				_priceFormat.size = 16;
				_priceFormat.bold = true;
				_priceFormat.color = 0x000000;
			}
			return _priceFormat;
		}
		
		private static var _titleFormat:TextFormat;
		private static function get titleFornmat () :TextFormat {
			if (!_titleFormat) {
				_titleFormat = new TextFormat();
				_titleFormat.align = TextFormatAlign.LEFT;
				_titleFormat.size = 14;
				_titleFormat.color = 0x000000;
			}
			return _titleFormat;
		}
		
		private static var _countFormat:TextFormat;
		private static function get countFornmat () :TextFormat {
			if (!_countFormat) {
				_countFormat = new TextFormat();
				_countFormat.align = TextFormatAlign.LEFT;
				_countFormat.size = 15;
				_countFormat.color = 0x222222;
				_countFormat.bold = true;
			}
			return _countFormat;
		}
		
		public function increment () :void {
			count ++;
			if (countLabel) {
				countLabel.text = count.toString();
			}
			if (count > 1) {
					countLabel.visible = true;
				} else {
					countLabel.visible = false;
				}
		}
		
		public function decrement () :void {
			count --;
			if (countLabel) {
				countLabel.text = count.toString();
			}
			if (count > 1) {
					countLabel.visible = true;
				} else {
					countLabel.visible = false;
				}
		}
		
		public function getCount() :int {
			return count;
		}
		
		public function get price () :int {
			return data.getPrice();
		}
		
		public function getCardData() :CollectionCardData {
			return data;
		}
		
	}

}