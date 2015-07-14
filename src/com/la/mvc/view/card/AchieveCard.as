package com.la.mvc.view.card 
{
	import com.la.mvc.model.AchieveData;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AchieveCard extends Sprite 
	{
		
		public static const MIRROR_WIDTH:int = 246;
		public static const MIRROR_HEIGHT:int = 358;
		
		public static const CARD_WIDTH:int = 132;
		public static const CARD_HEIGHT:int = 192;
		
		private var body:Sprite;
		
		private var data:AchieveData;
		
		private var priceLabel:TextField;
		private var mirrorPriceLabel:TextField; 
		private var titleLabel:TextField;
		private var mirrorTitleLabel:TextField;
		private var descriptionLabel:TextField;
		private var mirrorDescriptionLabel:TextField;
		private var typeLabel:TextField;
		private var countLabel:TextField;
		
		private var copy:Sprite;
		
		private var blockSprite:Sprite;
		private var blockFlag:Boolean = false;
		
		public function AchieveCard(data:AchieveData) 
		{
			super();
			
			this.data = data;
			
			formatCard();
			
		}
		
		public function getData() :AchieveData {
			return data;
		}
		
		private function formatCard () :void {
			body = new Sprite();
			CardFormater.drawBody(body, 1, CARD_WIDTH, CARD_HEIGHT, 25);
			addChild (body);
			
			priceLabel = CardFormater.getCollectionLabel (data.price);
            body.addChild (priceLabel);
			
			titleLabel = CardFormater.getTitleLabel (CARD_WIDTH, data.title);
            titleLabel.y = Math.round (CARD_HEIGHT * 0.4);
            body.addChild (titleLabel);
			
			descriptionLabel = CardFormater.getDescriptionLabel (CARD_WIDTH, data.description);
			descriptionLabel.y = Math.round (CARD_HEIGHT * 0.55);
			body.addChild (descriptionLabel);
			
			typeLabel = CardFormater.getTypeLabel (CARD_WIDTH);
			typeLabel.y = Math.round (CARD_HEIGHT * 0.9);
			body.addChild (typeLabel);
			if (data.autonomic) {
				typeLabel.text = 'автономная';
			} else {
				typeLabel.text = 'общая';
			}
			
			copy = new Sprite();
			copy.addChild(getBitmapCopy(this))
			
			blockSprite = new Sprite();
			blockSprite.graphics.beginFill(0x222222, 0.5);
			blockSprite.graphics.drawRect(0, 0, CARD_WIDTH, CARD_HEIGHT);
			blockSprite.graphics.endFill();
			
			countLabel = CardFormater.getCountLabel(20);
			countLabel.y = CARD_HEIGHT;
			countLabel.x = (CARD_WIDTH - countLabel.width) / 2;
			if (data.count > 1) {
				countLabel.text = 'x' + data.count;
				body.addChild(countLabel);
			}
			
		}
		
		public function block() :void {
			blockFlag = true;
			addChild(blockSprite);
		}
		
		public function unblock () :void {
			blockFlag = false;
			if (contains(blockSprite)) removeChild(blockSprite);
		}
		
		public function get isBlocked () :Boolean {
			return blockFlag;
		}
		
		public function getCopy() :Sprite {
			return copy;
		}
		
		private function getBitmapCopy (target:DisplayObject) :Bitmap {
			var bitmapData:BitmapData = new BitmapData (target.width, target.height, true, 0);
			bitmapData.draw (target);
			var bitmap:Bitmap = new Bitmap (bitmapData);
			return bitmap;
			
		}
		
	}

}