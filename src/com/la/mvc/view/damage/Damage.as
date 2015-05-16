package com.la.mvc.view.damage 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Damage extends Sprite 
	{
		[Embed(source = "../../../../../../lib/assets/bang.png")]
		private var Bang:Class;
		
		private var label:TextField
		
		public function Damage(value:int) 
		{
			this.mouseEnabled = false;
			var bang:Bitmap = new Bang() as Bitmap;
			addChild(bang);
			bang.x -= bang.width / 2;
			bang.y -= bang.height / 2;
			
			label = new TextField ();
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.mouseEnabled = false;
			label.defaultTextFormat = Damage.format;
			label.width = bang.width;
			label.height = 40;
			label.x = bang.x;
			label.y = bang.y + 20;
			label.text = value.toString();
			addChild (label);
		}
		
		private static var _format:TextFormat;
		private static function get format () :TextFormat {
			if (!_format) {
				_format = new TextFormat();
				_format.bold = true;
				_format.size = 36;
				_format.align = TextFormatAlign.CENTER;
				_format.color = 0xFFFFFF;
			}
			return _format;
		}
		
	}

}