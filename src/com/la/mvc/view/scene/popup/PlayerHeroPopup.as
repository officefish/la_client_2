package com.la.mvc.view.scene.popup 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PlayerHeroPopup extends Sprite 
	{
		
		private var lbl:TextField; 
		
		public function PlayerHeroPopup(msg:String, popupWidth:int = 120, popupHeight:int = 120) :void 
		{
			graphics.beginFill (0xFFFFFF, 1);
			graphics.drawRect (0, 0, popupWidth, popupHeight);
			graphics.endFill();
						
			lbl = new TextField ();
			lbl.width = this.width - 40;
			lbl.height = this.height - 40;
			lbl.x = 20;
			lbl.y = 20;
			lbl.wordWrap = true; 
			lbl.autoSize = TextFieldAutoSize.CENTER;
			lbl.defaultTextFormat = PlayerHeroPopup.format;
			lbl.text = msg;
		
			lbl.mouseEnabled = false;
			addChild (lbl);
		}
		
		private static var _format:TextFormat;
		private static function get format () :TextFormat {
			if (!_format) {
				_format = new TextFormat ();
				_format.size = 14;
				_format.bold = true;
				_format.align = TextFormatAlign.CENTER;
				_format.color = 0x222222;
			}
			return _format;
		}
		
	}

}