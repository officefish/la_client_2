package com.la.mvc.view.card 
{



import com.la.event.CardEvent;
import com.la.mvc.model.CollectionCardData;
import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

    import ru.flasher.utils.StringUtil
	import com.la.mvc.model.CardData;


	/**
	 * ...
	 * @author 
	 */
	
	 
	public class CollectionCard extends Sprite
	{
		
		private var mirror:Sprite
		private var priceLabel:TextField;
		private var mirrorPriceLabel:TextField;
		
		private var cardSensor:CardSensor;
		private var cardData:CollectionCardData;
		
		private var attackLabel:TextField;
		private var mirrorAttackLabel:TextField;
		
		private var healthLabel:TextField;
		private var mirrorHealthLabel:TextField;
		
		private var titleLabel:TextField;
		private var mirrorTitleLabel:TextField;
		
		private var descriptionLabel:TextField;
		private var mirrorDescriptionLabel:TextField;
		
		public static const MIRROR_WIDTH:int = 246;
		public static const MIRROR_HEIGHT:int = 358;
		
		public static const CARD_WIDTH:int = 132;
		public static const CARD_HEIGHT:int = 192;
		
        private var price:int;
        private var defaultPrice:int;

        private var priceFormat:TextFormat;
        private var saleFormat:TextFormat;
        private var expensiveFormat:TextFormat;

        private var mirrorPriceFormat:TextFormat;
        private var mirrorSaleFormat:TextFormat;
        private var mirrorExpensiveFormat:TextFormat;
		
		private var typeLabel:TextField;
		private var countLabel:TextField;
		
		private var mirrorTypeLabel:TextField;
		
		private var showCountFlag:Boolean;
		
		private var count:int;
		
		private var blockFlag:Boolean = false;
		
		private var blockSprite:Sprite;
		

       // private var hero:Hero;
	
		public function CollectionCard(cardData:CollectionCardData, showCount:Boolean = true) {
            showCountFlag = showCount;
			
			this.cardData = cardData;
            price = cardData.getPrice();
            defaultPrice = price;

            formatCard();
            formatMirror();
			
			buttonMode = true;
			
			addEventListener (MouseEvent.CLICK, onClick); 
        }
		
		private function onClick (event:MouseEvent) :void {
			dispatchEvent (new CardEvent (CardEvent.COLLECTION_CLICK, {card:this}))
		}

        private function formatCard () :void {
            CardFormater.drawBody(this, getType(), CARD_WIDTH, CARD_HEIGHT, 25);

            priceLabel = CardFormater.getCollectionLabel (price);
            addChild (priceLabel);
			
			if (getType() == CardData.UNIT) {
				attackLabel = CardFormater.getCollectionLabel (cardData.getAttack());
				attackLabel.y = this.height - attackLabel.height;
				addChild (attackLabel);
			}
			
			if (getType() == CardData.UNIT) {
				healthLabel = CardFormater.getCollectionLabel (cardData.getHealth());
				healthLabel.y = attackLabel.y;
				healthLabel.x = this.width - healthLabel.width; 
				addChild (healthLabel);
			}
			
			titleLabel = CardFormater.getTitleLabel (CARD_WIDTH, cardData.getTitle());
            titleLabel.y = Math.round (CARD_HEIGHT * 0.4);
            addChild (titleLabel);
			
			descriptionLabel = CardFormater.getDescriptionLabel (CARD_WIDTH, cardData.getDescription());
			descriptionLabel.y = Math.round (CARD_HEIGHT * 0.55);
			addChild (descriptionLabel);
			
			typeLabel = CardFormater.getTypeLabel (CARD_WIDTH);
			typeLabel.y = Math.round (CARD_HEIGHT * 0.9);
			addChild (typeLabel);
			
			if (cardData.getSubrace()) {
				typeLabel.text = cardData.getSubrace();
			} else if (cardData.getRace()) {
				typeLabel.text = cardData.getRace();
			} else {
				if (cardData.getType() == CardData.UNIT) {
					typeLabel.text = 'персонаж';
				} else if (cardData.getType() == CardData.SECRET) {
					typeLabel.text = 'секрет';
				}
				else {
					typeLabel.text = 'способность';
				}
			}
			
			count = cardData.getCount();
			if (showCountFlag) {
				countLabel = CardFormater.getCountLabel(20);
				countLabel.y = CARD_HEIGHT;
				countLabel.x = (CARD_WIDTH - countLabel.width) / 2;
				if (cardData.getCount() > 1) {
					countLabel.text = 'x' + count;
				}
				addChild(countLabel);
			}
			
			blockSprite = new Sprite ();
			blockSprite.graphics.beginFill (0x222222, 0.5);
			blockSprite.graphics.drawRect (0, 0, CARD_WIDTH, CARD_HEIGHT);
			blockSprite.graphics.endFill();
			blockSprite.mouseEnabled = false;
			
		}
		
		public function increment () :void {
			
			count ++
						
			if (countLabel) {
				countLabel.text = 'x' + cardData.getCount();
				if (count > 1) {
					addChild (countLabel);
				}
			}
			
			if (count > 0) {
				unblock();
			}
		}
		
		public function decrement () :void {
			count --
			if (countLabel) {
				countLabel.text = 'x' + cardData.getCount();
				if (count < 2) {
					if (contains(countLabel)) removeChild (countLabel);
				} 
			}
						
			if (count <= 0) {
				block();
			}
		}
		
		public function block () :void {
			blockFlag = true;
			addChild (blockSprite);
		}
		
		public function unblock () :void {
			blockFlag = false;
			if (contains(blockSprite)) {
				removeChild (blockSprite);
			}
		}
		
		public function isBlocked () :Boolean {
			return blockFlag;
		}
		
        private function formatMirror () :void {
            mirror = new Sprite();
            CardFormater.drawMirror(mirror, MIRROR_WIDTH, MIRROR_HEIGHT, cardData.getType(), 40);

            mirrorPriceLabel = CardFormater.getPreviewMirrorLabel(price);
            mirror.addChild (mirrorPriceLabel);

            mirrorAttackLabel = CardFormater.getPreviewMirrorLabel(cardData.getAttack());
            mirrorAttackLabel.y = mirror.height - 40;
            if (getType() == CardData.UNIT) {
                mirror.addChild (mirrorAttackLabel);
            }

            mirrorHealthLabel =  CardFormater.getPreviewMirrorLabel(cardData.getHealth());
            mirrorHealthLabel.x = mirror.width - 40;
            mirrorHealthLabel.y = mirrorAttackLabel.y;
            if (getType() == CardData.UNIT) {
                mirror.addChild (mirrorHealthLabel);
            }

            mirrorTitleLabel = CardFormater.getPreviewTitleLabel (MIRROR_WIDTH, cardData.getTitle());
            mirrorTitleLabel.y = Math.round (mirror.height * 0.4);
            mirror.addChild (mirrorTitleLabel);

            mirrorDescriptionLabel = CardFormater.getPreviewDescriptionLabel(MIRROR_WIDTH, parseDescription(cardData.getDescription()))
            mirrorDescriptionLabel.y = Math.round (mirror.height * 0.55);
            mirror.addChild (mirrorDescriptionLabel);
			
			mirrorTypeLabel = CardFormater.getPreviewTypeLabel (MIRROR_WIDTH);
			mirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.92);
			mirror.addChild (mirrorTypeLabel);
			
			if (cardData.getSubrace()) {
				mirrorTypeLabel.text = cardData.getSubrace();
			} else if (cardData.getRace()) {
				mirrorTypeLabel.text = cardData.getRace();
			} else {
				if (cardData.getType()) {
					mirrorTypeLabel.text = 'персонаж';
				} else {
					mirrorTypeLabel.text = 'способность';
				}
			}

        }
       

		public function getCardData () :CollectionCardData {
			return cardData;
		}
		
		public function getPrice () :int {
			return price;
		}

        

        private function parseDescription (str:String) :String {
            var spellBob:int = 0;
           
            var spellPower:int = cardData.getSpellPower() + spellBob;
            var result:String = StringUtil.format(str, spellPower);
            return result;
        }
	
		public function getMirror () :Sprite {
			return mirror;
		}
		
		public function getMirrorBitmap () :Bitmap {
			return getBitmapCopy (mirror);
		}
		
		private function getBitmapCopy (target:DisplayObject) :Bitmap {
			var bitmapData:BitmapData = new BitmapData (target.width, target.height, true, 0);
			
			bitmapData.draw (target);
			var bitmap:Bitmap = new Bitmap (bitmapData);
			return bitmap;
			
		}

        public function getType () :int {
            return cardData.getType();
        }

        public function glowMirror () :void {
            getMirror().filters = [new GlowFilter (0x00FFFF)];
        }

        public function stopGlowMirror () :void {
            getMirror().filters = [];
        }
		
		
	}

}