package com.la.mvc.view.field 
{
	import com.la.mvc.model.FieldAchieveData;
	import com.la.mvc.view.card.CardFormater;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldAchieveSlot extends Sprite 
	{
		
		private var data:FieldAchieveData;
		private var label:TextField;
		
		private var priceWidget:Sprite;
		private var priceLabel:TextField;
		
		private var priceStepWidget:FieldAchievePriceWidget;
		
		private var mirror:Sprite;
		
		private var mirrorIcon:Sprite;
		private var mirrorIconTitleLabel:TextField;
		private var mirrorTitleLabel:TextField;
		private var mirrorDescriptionLabel:TextField;
		private var mirrorAutonomicLabel:TextField;
		private var mirrorPriceWidget:Sprite;
		private var mirrorPriceWidgetLabel:TextField;
		
		private var body:Sprite;
		
		private var _playerFlag:Boolean;
		private var enableFlag:Boolean = false;
		
		private var type:int;
		private var position:int;
		
		public function FieldAchieveSlot(data:FieldAchieveData, playerFlag:Boolean = true) 
		{
			this.data = data;
			this._playerFlag = playerFlag;
			this.type = data.type;
			this.position = data.position;
			
			body = new Sprite();
			body.graphics.beginFill(0xCCCCCC, 1);
			body.graphics.drawCircle(30,30,30);
			body.graphics.endFill();
			addChild(body);
			
			body.buttonMode = true;
			
			label = new TextField();
			label.defaultTextFormat = FieldAchieveSlot.format;
			label.mouseEnabled = false;
			label.width = 50;
			label.height = 20;
			label.x = 5;
			label.y = 25;
			label.text = data.title;
			addChild(label);
			
			priceWidget = new Sprite();
			priceWidget.graphics.beginFill(0x777777, 1);
			priceWidget.graphics.drawRect(0, 0, 10, 15);
			priceWidget.graphics.endFill();
			priceWidget.x = 25;
			if (playerFlag) {
				priceWidget.y = 45;
			} else {
				priceWidget.y = -0;
			}
			addChild(priceWidget)
			
			priceLabel = new TextField();
			priceLabel.defaultTextFormat = FieldAchieveSlot.priceFormat;
			priceLabel.mouseEnabled = false;
			priceLabel.width = 10;
			priceLabel.height = 15;
			priceLabel.text = data.price.toString();
			priceWidget.addChild(priceLabel);
			
			if (data.autonomic) {
				priceStepWidget = new FieldAchievePriceWidget(data.price, playerFlag);
				priceStepWidget.x = -10;
				priceStepWidget.y = - 10;
				addChild(priceStepWidget);
			}
			
			formatMirror ();
		}
		
		public function getType () :int {
			return type;
		}
		
		public function getPosition() :int {
			return position;
		}
		
		public function enable () :void {
			enableFlag = true;
			body.filters = [new GlowFilter (0x00FFFF)]; 
		}
		
		public function disable () :void {
			enableFlag = false;
			body.filters = null; 
			if (priceStepWidget) {
				priceStepWidget.disable();
			}
		}
		
		public function isActive() :Boolean {
			return enableFlag;
		}
		
		public function increment(price:int) :void {
			priceStepWidget.increment(price);
		}
		
		public function get isEnemyAchieve() :Boolean {
			return (!_playerFlag)
		}
		
		private static var _format:TextFormat;
		private static function get format ():TextFormat {
			if (!_format) {
				_format = new TextFormat();
				_format.size = 10;
				_format.align = TextFormatAlign.CENTER;
				_format.bold = true;
			}
			return _format;
		}
		private static var _priceformat:TextFormat;
		private static function get priceFormat ():TextFormat {
			if (!_priceformat) {
				_priceformat = new TextFormat();
				_priceformat.size = 11;
				_priceformat.align = TextFormatAlign.CENTER;
				_priceformat.bold = true;
				_priceformat.color = 0xEEEEEE;
			}
			return _priceformat;
		}
		
		private function formatMirror () :void {
			mirror = new Sprite ();
			mirror.graphics.beginFill (0xAAAAAA, 1);
			mirror.graphics.drawRect(0, 0, 140, 180);
			mirror.graphics.endFill();
			
			mirrorIcon = new Sprite();
			mirrorIcon.graphics.beginFill(0xCCCCCC, 1);
			mirrorIcon.graphics.drawCircle(30,30,30);
			mirrorIcon.graphics.endFill();
			mirrorIcon.x = 40;
			mirrorIcon.y = 10;
			mirror.addChild(mirrorIcon)
			
			mirrorIconTitleLabel = new TextField();
			mirrorIconTitleLabel.defaultTextFormat = FieldAchieveSlot.format;
			mirrorIconTitleLabel.mouseEnabled = false;
			mirrorIconTitleLabel.width = 50;
			mirrorIconTitleLabel.height = 20;
			mirrorIconTitleLabel.x = 5;
			mirrorIconTitleLabel.y = 25;
			mirrorIconTitleLabel.text = data.title;
			mirrorIcon.addChild(mirrorIconTitleLabel);
			
			mirrorTitleLabel = CardFormater.getTitleLabel (140, data.title);
            mirrorTitleLabel.y = Math.round (180 * 0.45);
			mirror.addChild(mirrorTitleLabel);
			
			mirrorDescriptionLabel = CardFormater.getDescriptionLabel (140 , data.description);
			mirrorDescriptionLabel.height = 70;
			mirrorDescriptionLabel.y = Math.round (180 * 0.55);
			mirror.addChild (mirrorDescriptionLabel);
		
			mirrorAutonomicLabel = CardFormater.getTypeLabel (140);
			mirrorAutonomicLabel.y = Math.round (180 * 0.9);
			if (data.autonomic) {
				mirrorAutonomicLabel.text = 'автономная';
			} else {
				mirrorAutonomicLabel.text = 'общая';
			}
			mirror.addChild(mirrorAutonomicLabel);
			
			mirrorPriceWidget = new Sprite();
			mirrorPriceWidget.graphics.beginFill(0xEEEEEE, 1);
			mirrorPriceWidget.graphics.drawRect(0, 0, 25, 25);
			mirrorPriceWidget.graphics.endFill();
			mirror.addChild(mirrorPriceWidget);
			
			mirrorPriceWidgetLabel = CardFormater.getCollectionLabel (data.price);
            mirror.addChild (mirrorPriceWidgetLabel);
		

		}
		
		public function getMirror() :Sprite {
			return mirror;
		}
		
	}

}