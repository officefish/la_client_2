package com.la.mvc.view.achieves 
{
	import com.la.mvc.model.AchieveData;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveSlot extends Sprite 
	{
		
		private var label:TextField;
		private var data:AchieveData;
		
		public function AchieveSlot(data:AchieveData) 
		{
			this.data = data;
			
			graphics.beginFill(0xCCCCCC, 1);
			graphics.drawCircle(35,35,35);
			graphics.endFill();		
			
			label = new TextField();
			label.defaultTextFormat = AchieveSlot.format;
			label.mouseEnabled = false;
			label.width = 60;
			label.height = 20;
			label.x = 5;
			label.y = 25;
			label.text = data.title;
			addChild(label);

		}
		
		public function get achieveId():int {
			return data.id;
		}
		
		private static var _format:TextFormat;
		private static function get format ():TextFormat {
			if (!_format) {
				_format = new TextFormat();
				_format.size = 12;
				_format.align = TextFormatAlign.CENTER;
				_format.bold = true;
			}
			return _format;
		}
		
	}

}