package com.la.mvc.view.field.deck 
{
	import com.la.mvc.model.MiniCardData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldDeckSlot extends Sprite 
	{
		private var data:MiniCardData;
		private var priceField:TextField;
		private var mirror:Sprite;
		
		private var _position:int;
		
		private var titleLabel:TextField;
		
		public function FieldDeckSlot(data:MiniCardData)
		{
			this.data = data;
			
			graphics.beginFill(0x222222, 1);
			graphics.drawRect(0, 0, 24, 24);
			graphics.endFill();
			
			priceField = new TextField ();
			priceField.width = 24;
			priceField.height = 20;
			priceField.y = 4;
			addChild(priceField);
			priceField.mouseEnabled = false;
			priceField.defaultTextFormat = FieldDeckSlot.priceFormat;
			priceField.text = data.price.toString();
			
			this.mirror = new Sprite();
			this.mirror.graphics.beginFill(0xFFFFFF, 1);
			this.mirror.graphics.drawRect(0, 0, 120, 30);
			mirror.graphics.endFill();
			
			titleLabel = new TextField();
			titleLabel.width = 120;
			titleLabel.height = 25;
			titleLabel.y = 4;
			titleLabel.mouseEnabled = false;
			titleLabel.defaultTextFormat = titleFormat;
			titleLabel.text = data.title.toString();
			mirror.addChild(titleLabel);
			
			
		}
		
		public function set position (value:int) :void {
			_position = value;
		}
		
		public function get position () :int {
			return _position;
		}
		
		public function set index (value:int) :void {
			this.data.index = value;
		}
		
		public function get index () :int {
			return this.data.index;
		}
		
		public function getMirror () :Sprite {
			return mirror;
		}
		
		public static var _priceFormat:TextFormat 
		public static function get priceFormat () :TextFormat {
			if (!_priceFormat) {
				_priceFormat = new TextFormat ();
				_priceFormat.color = 0xFFFFFF;
				_priceFormat.bold = true;
				_priceFormat.align = TextFormatAlign.CENTER;
			}
			return _priceFormat;
			
		}
		
		public static var _titleFormat:TextFormat 
		public static function get titleFormat () :TextFormat {
			if (!_titleFormat) {
				_titleFormat = new TextFormat ();
				_titleFormat.color = 0x222222;
				_titleFormat.bold = true;
				_titleFormat.align = TextFormatAlign.CENTER;
			}
			return _titleFormat;
			
		}
		
		public function set drugMode (value:Boolean) :void {
			if (value) {
				graphics.clear();
				graphics.beginFill(0xAAAAAA, 1);
				graphics.drawRect(0, 0, 24, 24);
				graphics.endFill();
			} else {
				graphics.clear();
				graphics.beginFill(0x222222, 1);
				graphics.drawRect(0, 0, 24, 24);
				graphics.endFill();
			}
			
		}
		
		public function clone () :FieldDeckSlot {
			var cloneSlot:FieldDeckSlot = new FieldDeckSlot(data);
			return cloneSlot;
		}
		
	}

}