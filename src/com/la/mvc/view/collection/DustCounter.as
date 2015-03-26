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
	public class DustCounter extends Sprite 
	{
		
		private var lbl:TextField;
		private var dustLbl:TextField;
		
		public function DustCounter() 
		{
			graphics.beginFill (0xEEEEEE, 1);
			graphics.drawRect (0, 0, 140, 70);
			graphics.endFill ();
			
			lbl = new TextField ();
			lbl.width = this.width;
			lbl.height = 25;
			lbl.y = 10;
			lbl.defaultTextFormat = lblFormat;
			lbl.text = 'Доступно пыли:';
			lbl.mouseEnabled = false;
			
			addChild (lbl);
			
			dustLbl = new TextField ();
			dustLbl.width = this.width;
			dustLbl.height = 25;
			dustLbl.y = 35;
			dustLbl.defaultTextFormat = dustFormat;
			dustLbl.mouseEnabled = false;
			addChild (dustLbl);
			
		
		}
		
		private var _dustFormat:TextFormat;
		private function get dustFormat():TextFormat {
			if (!_dustFormat) {
				_dustFormat = new TextFormat;
				_dustFormat.bold = true;
				_dustFormat.size = 16;
				_dustFormat.color = 0x151B54;
				_dustFormat.align = TextFormatAlign.CENTER;
			}
			return _dustFormat;
		}
		
		private var _format:TextFormat;
		private function get lblFormat () :TextFormat {
			if (!_format) {
				_format = new TextFormat;
				_format.bold = true;
				_format.size = 13;
				_format.align = TextFormatAlign.CENTER;
			}
			return _format;
		}
		
		public function setDust (value:int) :void {
			dustLbl.text = value.toString();

		}
		
	
		
	}

}