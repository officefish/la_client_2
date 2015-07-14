package com.la.mvc.view.ui 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class SmallButton extends Sprite 
	{
		protected var label:TextField; 
		
		private var bWidth:int;
		private var bHeight:int;
		
		protected var blockFlag:Boolean = false;
		
		public function SmallButton(value:String, bWidth:int = 70, bHeight:int = 35) 
		{
			this.bHeight = bHeight;
			this.bWidth = bWidth;
			
			graphics.beginFill (0x151B54);
			graphics.drawRect (0, 0, bWidth, bHeight);
			graphics.endFill ();
			
			label = new TextField ();
			label.defaultTextFormat = format;
			label.width = this.width;
			label.mouseEnabled = false;
			label.y = 7;
			label.height = 20;
			label.text = value;
			addChild(label)
		
			buttonMode = true;
			
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
		}
		
		private var _format:TextFormat;
		protected function get format () :TextFormat {
			if (_format == null) {
				_format = new TextFormat;
				_format.align = TextFormatAlign.CENTER;
				_format.color = 0xEEEEEE;
				_format.size = 14;
				_format.bold = true;
			}
			return _format;
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			if (blockFlag) return;
			graphics.clear();
			graphics.beginFill (0x2B65EC);
			graphics.drawRect (0, 0, bWidth, bHeight);
			graphics.endFill ();
		}
		
		public function defaultState() :void {
			graphics.clear();
			graphics.beginFill (0x151B54);
			graphics.drawRect (0, 0, bWidth, bHeight);
			graphics.endFill ();
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			if (blockFlag) return;
			graphics.clear();
			graphics.beginFill (0x151B54);
			graphics.drawRect (0, 0, bWidth, bHeight);
			graphics.endFill ();
		}		
	}

}