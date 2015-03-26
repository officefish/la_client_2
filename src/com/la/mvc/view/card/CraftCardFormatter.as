package com.la.mvc.view.card 
{
	import flash.display.Sprite;
	import com.la.mvc.model.CardData;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftCardFormatter 
	{
		
	
		
		public static function drawBody (target:Sprite, type:int, width:int, height:int, square:int = 21) :void {

			target.graphics.beginFill (0x82CAFF, 1);
			target.graphics.drawRect (0, 0, width, height);
			target.graphics.endFill();

			target.graphics.lineStyle (1, 0xADDFFF, 1);
			target.graphics.lineTo (width, 0);
			target.graphics.lineTo (width, height);
			target.graphics.lineTo(0, height);
			target.graphics.lineTo (0, 0);

			target.graphics.beginFill (0xADDFFF, 1);

			target.graphics.drawRect (0, 0, square, square);
			target.graphics.endFill ();
			
			if (type == CardData.UNIT) { 
				target.graphics.beginFill (0xADDFFF, 1);
				target.graphics.drawRect (0, height - square, square, square);
				target.graphics.endFill ();
			}
			if (type == CardData.UNIT) {
				target.graphics.beginFill (0xADDFFF, 1);
				target.graphics.drawRect (width - square, height - square, square, square);
				target.graphics.endFill ();
			}
		}
		
		public static function drawMirror (mirror:Sprite, width:int, height:int, type:int, square:int = 30) :void {
			mirror.graphics.beginFill (0x82CAFF, 1);
			mirror.graphics.drawRect (0, 0, width, height);
			mirror.graphics.endFill();

			mirror.graphics.lineStyle (1, 0xADDFFF, 1);
			mirror.graphics.lineTo (width, 0);
			mirror.graphics.lineTo (width, height);
			mirror.graphics.lineTo(0, height);
			mirror.graphics.lineTo (0, 0);

			if (type == CardData.UNIT) {
				mirror.graphics.beginFill (0xADDFFF, 1);
				mirror.graphics.drawRect (0, height-square, square, square);
				mirror.graphics.endFill ();
			}

			if (type == CardData.UNIT) {
				mirror.graphics.beginFill (0xADDFFF, 1);
				mirror.graphics.drawRect (width-square, height-square, square, square);
				mirror.graphics.endFill ();
			}

			mirror.graphics.beginFill (0xADDFFF, 1);
			mirror.graphics.drawRect (0, 0, square, square);
			mirror.graphics.endFill ();
		}
		
		public static function getLabel (value:int) :TextField {
			var label:TextField = new TextField ();
			label.defaultTextFormat = labelFormat;
			label.text = "" + value;
			label.wordWrap = false;
			label.width = 25;
			label.height = 25; 
			label.mouseEnabled = false;
			return label;
		}
		
		 public static function getMirrorLabel (price:int) :TextField {
			var label:TextField = new TextField ();
			label.height = 40;
			label.defaultTextFormat = mirrorFormat;
			label.text = "" + price;
			label.width = 40;
			label.mouseEnabled = false;
			return label;
		}
		
		public static function getTitleLabel (width:int, title:String) :TextField {
			var label:TextField = new TextField ();
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.width = width; 
			label.defaultTextFormat = titleFormat;
			label.text = title;
			label.mouseEnabled = false;
			return label;
		}
		
		public static function getDescriptionLabel (width:int, description:String) :TextField {
			var label:TextField = new TextField ();
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.width = width - 10;
			label.x = 5;
			label.wordWrap = true;
			label.defaultTextFormat = descriptionFormat;
			label.text = description;
			label.mouseEnabled = false;
			return label;
		}
		
		public static function getTypeLabel (width:int) :TextField {
			var label:TextField = new TextField ();
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.width = width;
			label.height = 19;
			label.defaultTextFormat = typeFormat;
			label.mouseEnabled = false;
			return label;
		}
		
		  public static function getMirrorTitleLabel (width:int, title:String) :TextField {
			var label:TextField = new TextField ();
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.width = width;
			label.defaultTextFormat = mirrorTitleFormat;
			label.text = title;
			label.mouseEnabled = false;
			return label;
		}
		
		public static function getMirrorDescriptionLabel (width:int, title:String) :TextField {
			var label:TextField = new TextField ();
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.width = width - 20;
			label.x = 10;
			label.wordWrap = true;
			label.defaultTextFormat = mirrorDescriptionFormat;
			label.text = title;
			label.mouseEnabled = false;
			return label;
		}
		
		public static function getMirrorTypeLabel (width:int) :TextField {
			var label:TextField = new TextField ();
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.width = width;
			label.height = 25;
			label.defaultTextFormat = mirrorTypeFormat;
			label.mouseEnabled = false;
			return label;
		}
			
		private static var _labelFormat:TextFormat;
		public static function get labelFormat () :TextFormat {
				 if (!_labelFormat) {
				_labelFormat = new TextFormat();
				_labelFormat.size = 15;
				_labelFormat.bold = true;
				_labelFormat.color = 0xFFFFFF;
				_labelFormat.align = TextFormatAlign.CENTER;
			} 
			return _labelFormat;
		}
		
		private static var _titleFormat:TextFormat;
		public static function get titleFormat () :TextFormat {
			if (!_titleFormat) {
            _titleFormat = new TextFormat();
            _titleFormat.align = TextFormatAlign.CENTER;
            _titleFormat.size = 12;
            _titleFormat.bold = true;
            _titleFormat.color = 0xFFFFFF;
        }
        return _titleFormat;
		}
		
		private static var _descriptionFormat:TextFormat;
		public static function get descriptionFormat () :TextFormat {
			if (!_descriptionFormat) {
				_descriptionFormat = new TextFormat();
				_descriptionFormat.align = TextFormatAlign.CENTER;
				_descriptionFormat.size = 11;
				_descriptionFormat.color = 0xFFFFFF;
			}
			return _descriptionFormat;
		}
		
		private static var _typeFormat:TextFormat;
		public static function get typeFormat () :TextFormat {
			if (!_typeFormat) {
				_typeFormat = new TextFormat();
				_typeFormat.align = TextFormatAlign.CENTER;
				_typeFormat.size = 11;
				_typeFormat.bold = true;
				_typeFormat.color = 0xFFFFFF;
			}
			return _typeFormat;
		}
		
		private static var _mirrorFormat:TextFormat;
		public static function get mirrorFormat () :TextFormat {
			if (!_mirrorFormat) {
				_mirrorFormat = new TextFormat();
				_mirrorFormat.size = 30;
				_mirrorFormat.bold = true;
				_mirrorFormat.color = 0xFFFFFF;
				_mirrorFormat.align = TextFormatAlign.CENTER;
			}
			return _mirrorFormat;
		}
		
		private static var _mirrorTitleFormat:TextFormat;
		public static function get mirrorTitleFormat () :TextFormat {
			if (!_mirrorTitleFormat) {
				_mirrorTitleFormat = new TextFormat();
				_mirrorTitleFormat.align = TextFormatAlign.CENTER;
				_mirrorTitleFormat.size = 24;
				_mirrorTitleFormat.bold = true;
				_mirrorTitleFormat.color = 0xFFFFFF;
			}
			return _mirrorTitleFormat;
		}
		
		private static var _previewDescriptionFormat:TextFormat;
		public static function get mirrorDescriptionFormat () :TextFormat {
			if (!_previewDescriptionFormat) {
				_previewDescriptionFormat = new TextFormat();
				_previewDescriptionFormat.align = TextFormatAlign.CENTER;
				_previewDescriptionFormat.size = 15;
				_previewDescriptionFormat.bold = true;
				_previewDescriptionFormat.color = 0xFFFFFF;
			}
			return _previewDescriptionFormat;
		}
		
		private static var _mirrorTypeFormat:TextFormat;
		public static function get mirrorTypeFormat () :TextFormat {
			if (!_mirrorTypeFormat) {
				_mirrorTypeFormat = new TextFormat();
				_mirrorTypeFormat.align = TextFormatAlign.CENTER;
				_mirrorTypeFormat.size = 16;
				_mirrorTypeFormat.bold = true;
				_mirrorTypeFormat.color = 0xFFFFFF;
			}
			return _mirrorTypeFormat;
		}
	}

}