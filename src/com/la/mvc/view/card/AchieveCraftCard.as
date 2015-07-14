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
	public class AchieveCraftCard extends Sprite 
	{
		
		public static const MIRROR_WIDTH:int = 246;
		public static const MIRROR_HEIGHT:int = 358;
		
		public static const CARD_WIDTH:int = 132;
		public static const CARD_HEIGHT:int = 192;
		
		private var body:Sprite;
		private var mirror:Sprite;
		private var craftMirror:Sprite;
		private var craftBody:Sprite;

		
		private var data:AchieveData;
		
		private var priceLabel:TextField;
		private var mirrorPriceLabel:TextField; 
		private var titleLabel:TextField;
		private var typeLabel:TextField; 
		private var countLabel:TextField;
		
		private var mirrorTitleLabel:TextField;
		private var descriptionLabel:TextField;
		private var mirrorDescriptionLabel:TextField;
		private var mirrorTypeLabel:TextField;
		
		private var craftTitleLabel:TextField;
		private var craftDescriptionLabel:TextField;
		private var craftPriceLabel:TextField;
		private var craftTypeLabel:TextField;
		
		private var craftMirrorTitleLabel:TextField;
		private var craftMirrorDescriptionLabel:TextField;
		private var craftMirrorPriceLabel:TextField;
		private var craftMirrorTypeLabel:TextField;
	
		private var blockSprite:Sprite;
		private var blockFlag:Boolean = false;
		
		private var state:int = 0;
		
		public static const DEFAULT_STATE:int = 0;
		public static const CRAFT_STATE:int = 1;
		
		private var _mirrorBitmap:Bitmap;
		private var _craftMirrorBitmap:Bitmap;
		
		private var copy:Sprite;
		
		public function AchieveCraftCard(data:AchieveData) 
		{
			super();
			
			this.data = data;
			
			copy = new Sprite();
			
			formatCard();
			formatCraftCard();
			
			formatMirror();
			formatCraftMirror();
			
			if (data.count) {
				this.state = DEFAULT_STATE;
				addChild(body);
			} else {
				this.state = CRAFT_STATE;
				addChild(craftBody);
			}
			
			this.buttonMode = true;
		}
		
		public function setCount(value:int) :void {
			this.data.count = value;
			if (value) {
				setState(DEFAULT_STATE)
			} else {
				setState(CRAFT_STATE)
			}
			if (body.contains(countLabel)) {
				body.removeChild(countLabel);
			} 
			if (value > 1) {
				countLabel.text = 'x' + value;
				body.addChild(countLabel);
			}
		}
		
		public function getData() :AchieveData {
			return data;
		}
		
		private function formatCard () :void {
			body = new Sprite();
			CardFormater.drawBody(body, 1, CARD_WIDTH, CARD_HEIGHT, 25);
			
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
			
			countLabel = CardFormater.getCountLabel(20);
			countLabel.y = CARD_HEIGHT;
			countLabel.x = (CARD_WIDTH - countLabel.width) / 2;
			if (data.count > 1) {
				countLabel.text = 'x' + data.count;
				body.addChild(countLabel);
			}
			
			blockSprite = new Sprite();
			blockSprite.graphics.beginFill(0x222222, 0.5);
			blockSprite.graphics.drawRect(0, 0, CARD_WIDTH, CARD_HEIGHT);
			blockSprite.graphics.endFill();
			
			
		}
		
		private function formatCraftCard():void {
			craftBody = new Sprite;
			CraftCardFormatter.drawBody(craftBody, 1, CARD_WIDTH, CARD_HEIGHT, 25);
			
			craftPriceLabel = CraftCardFormatter.getLabel (data.price);
            craftBody.addChild (craftPriceLabel);
			
			craftTitleLabel = CraftCardFormatter.getTitleLabel (CARD_WIDTH, data.title);
            craftTitleLabel.y = Math.round (CARD_HEIGHT * 0.4);
            craftBody.addChild (craftTitleLabel);
			
			craftDescriptionLabel = CraftCardFormatter.getDescriptionLabel (CARD_WIDTH, data.description);
			craftDescriptionLabel.y = Math.round (CARD_HEIGHT * 0.55);
			craftBody.addChild (craftDescriptionLabel);
			
			craftTypeLabel = CraftCardFormatter.getTypeLabel (CARD_WIDTH);
			craftTypeLabel.y = Math.round (CARD_HEIGHT * 0.9);
			craftBody.addChild (craftTypeLabel);
			
			if (data.autonomic) {
				craftTypeLabel.text = 'автономная';
			} else {
				craftTypeLabel.text = 'общая';
			}
			
			
		}
		
		  private function formatMirror () :void {
            mirror = new Sprite();
            CardFormater.drawMirror(mirror, MIRROR_WIDTH, MIRROR_HEIGHT, 1, 40);

            mirrorPriceLabel = CardFormater.getPreviewMirrorLabel(data.price);
            mirror.addChild (mirrorPriceLabel);

            mirrorTitleLabel = CardFormater.getPreviewTitleLabel (MIRROR_WIDTH, data.title);
            mirrorTitleLabel.y = Math.round (mirror.height * 0.4);
            mirror.addChild (mirrorTitleLabel);

            mirrorDescriptionLabel = CardFormater.getPreviewDescriptionLabel(MIRROR_WIDTH, data.description)
            mirrorDescriptionLabel.y = Math.round (mirror.height * 0.55);
            mirror.addChild (mirrorDescriptionLabel);
			
			mirrorTypeLabel = CardFormater.getPreviewTypeLabel (MIRROR_WIDTH);
			mirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.92);
			mirror.addChild (mirrorTypeLabel);
			
			if (data.autonomic) {
				mirrorTypeLabel.text = 'автономная';
			} else {
				mirrorTypeLabel.text = 'общая';
			}
		}
		
		private function formatCraftMirror () :void {
			craftMirror = new Sprite();
            CraftCardFormatter.drawMirror(craftMirror, MIRROR_WIDTH, MIRROR_HEIGHT, 1, 40);

            craftMirrorPriceLabel = CraftCardFormatter.getMirrorLabel(data.price);
			craftMirror.addChild (craftMirrorPriceLabel);

            craftMirrorTitleLabel = CraftCardFormatter.getMirrorTitleLabel (MIRROR_WIDTH, data.title);
            craftMirrorTitleLabel.y = Math.round (craftMirror.height * 0.4);
            craftMirror.addChild (craftMirrorTitleLabel);

            craftMirrorDescriptionLabel = CraftCardFormatter.getMirrorDescriptionLabel(MIRROR_WIDTH, data.description)
            craftMirrorDescriptionLabel.y = Math.round (craftMirror.height * 0.55);
            craftMirror.addChild (craftMirrorDescriptionLabel);
						
			craftMirrorTypeLabel = CraftCardFormatter.getMirrorTypeLabel (MIRROR_WIDTH);
			craftMirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.92);
			craftMirror.addChild (craftMirrorTypeLabel);
			
			if (data.autonomic) {
				craftMirrorTypeLabel.text = 'автономная';
			} else {
				craftMirrorTypeLabel.text = 'общая';
			}
		}
		
		public function getMirror() :Sprite {
			if (state) {
				return craftMirror;
			} else {
				return mirror;
			}
		}
		
		public function setState(value:int) :void {
			this.state = value;
			
			while (this.numChildren) this.removeChildAt(0);
			if (this.state == DEFAULT_STATE) {
				addChild(body);
			} else {
				addChild(craftBody);
			}
		}
		
		public function getMirrorBitmapCopy () :Sprite {
			while (copy.numChildren) copy.removeChildAt(0)
			if (state) {
				copy.addChild(craftMirrorBitmap)
			} else {
				copy.addChild(mirrorBitmap)
			}
			return copy;
		}
		
		private function get mirrorBitmap () :Bitmap {
			if (!_mirrorBitmap) {
				_mirrorBitmap = getBitmapCopy(mirror)
			}
			return _mirrorBitmap;
		}
		
		private function get craftMirrorBitmap () :Bitmap {
			if (!_craftMirrorBitmap) {
				_craftMirrorBitmap = getBitmapCopy(craftMirror)
			}
			return _craftMirrorBitmap;
		}
		
		private function getBitmapCopy (target:DisplayObject) :Bitmap {
			var bitmapData:BitmapData = new BitmapData (target.width, target.height, true, 0);
			bitmapData.draw (target);
			var bitmap:Bitmap = new Bitmap (bitmapData);
			return bitmap; 
			
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
		
		
		
		
		
	}

}