package com.la.mvc.view.card 
{
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AttritionCard extends Sprite
	{
		
		private var label:TextField;
		private var damageLabel:TextField;
		
		public function AttritionCard(damage:int) 
		{
			graphics.beginFill(0x222222, 1);
			graphics.drawRect(0, 0, Card.MIRROR_WIDTH, Card.MIRROR_HEIGHT);
			graphics.endFill();
			
			label = new TextField();
			label.mouseEnabled = false;
			label.antiAliasType = AntiAliasType.ADVANCED;
			label.width = this.width;
			label.y = this.height / 2 - 30;
			label.defaultTextFormat = AttritionCard.labelFormat;
			label.text = 'Истощение';
			addChild (label);
			
			damageLabel = new TextField();
			damageLabel.mouseEnabled = false;
			damageLabel.antiAliasType = AntiAliasType.ADVANCED;
			damageLabel.width = this.width;
			damageLabel.y = this.height / 2 + 30;
			damageLabel.defaultTextFormat = AttritionCard.labelFormat;
			damageLabel.text = '- ' + damage.toString() + ' урона';
			addChild (damageLabel);
			
		}
		
		private static var _labelFormat:TextFormat;
		private static function get labelFormat() :TextFormat {
			if (!_labelFormat) {
				_labelFormat = new TextFormat();
				_labelFormat.align = TextFormatAlign.CENTER;
				_labelFormat.bold = true;
				_labelFormat.size = 16;
				_labelFormat.color = 0xEEEEEE;
			}
			return _labelFormat;
		}
		
		private static var _damageLabelFormat:TextFormat;
		private static function get damageLabelFormat() :TextFormat {
			if (!_damageLabelFormat) {
				_damageLabelFormat = new TextFormat();
				_damageLabelFormat.align = TextFormatAlign.CENTER;
				_damageLabelFormat.size = 14;
				_damageLabelFormat.color = 0xEEEEEE;
			}
			return _damageLabelFormat;
		}
		
	}

}