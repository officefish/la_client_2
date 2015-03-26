package com.la.mvc.view.ui 
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CraftButton extends SmallButton 
	{
		
		private var priceLabel:TextField;
		
		private var _block:Sprite;
		
		public function CraftButton(value:String, bWidth:int=70, bHeight:int=35) 
		{
			super(value, bWidth, bHeight);
			label.y = 15;
			
			priceLabel = new TextField ();
			priceLabel.defaultTextFormat = priceFormat;
			priceLabel.width = this.width;
			priceLabel.mouseEnabled = false;
			priceLabel.y = 35;
			priceLabel.height = 20;
			addChild(priceLabel)
			
			_block = new Sprite();
			_block.graphics.beginFill (0x222222, 0.7);
			_block.graphics.drawRect (0, 0, this.width, this.height);
			_block.graphics.endFill ();
		}
		
		private var _priceFormat:TextFormat;
		protected function get priceFormat () :TextFormat {
			if (_priceFormat == null) {
				_priceFormat = new TextFormat;
				_priceFormat.align = TextFormatAlign.CENTER;
				_priceFormat.color = 0xEEEEEE;
				_priceFormat.size = 18; 
				_priceFormat.bold = true;
			}
			return _priceFormat;
			
		}
		
		public function block () :void {
			blockFlag = true;
			addChild (_block);
		} 
		
		public function unblock () :void {
			blockFlag = false;
			if (contains(_block)) removeChild (_block);
		}
		
		public function isBlock () :Boolean {
			return blockFlag;
		}
		
		public function setPrice (value:int) :void {
			priceLabel.text = value.toString();
		}
		
	}

}