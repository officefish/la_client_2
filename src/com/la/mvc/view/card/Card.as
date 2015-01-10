package com.la.mvc.view.card
{

import com.log.Logger;
import com.la.mvc.model.CardData;


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



/**
	 * ...
	 * @author 
	 */
	
	 
	public class Card extends Sprite
	{
		
		private var mirror:Sprite
		private var cardSensor:CardSensor;
		private var cardData:CardData;

		private var priceLabel:TextField;
		private var attackLabel:TextField;
		private var healthLabel:TextField;
		private var descriptionLabel:TextField;
		private var titleLabel:TextField;
		
		private var mirrorPriceLabel:TextField;
		private var mirrorAttackLabel:TextField;
		private var mirrorHealthLabel:TextField;
		private var mirrorTitleLabel:TextField;
		private var mirrorDescriptionLabel:TextField;
		private var mirrorTypeLabel:TextField;

		public static const MIRROR_WIDTH:int = 154;
		public static const MIRROR_HEIGHT:int = 224;
		
		public static const CARD_WIDTH:int = 110;
		public static const CARD_HEIGHT:int = 160;
		
		private var shirt:Sprite;
		private var smallShirt:Sprite;

        private var price:int;
        private var defaultPrice:int;

        private var priceFormat:TextFormat;
        private var saleFormat:TextFormat;
        private var expensiveFormat:TextFormat;

        private var mirrorPriceFormat:TextFormat;
        private var mirrorSaleFormat:TextFormat;
        private var mirrorExpensiveFormat:TextFormat;
	
		public function Card(cardData:CardData) {
            this.cardData = cardData;
            price = cardData.getPrice();
            defaultPrice = price;

            formatCard();
            formatMirror();
            formatShirt();
        }

        private function formatCard () :void {
            CardFormater.drawBody(this, getType(), CARD_WIDTH, CARD_HEIGHT);

            priceLabel = CardFormater.getLabel (price);
            addChild (priceLabel);
            cardSensor = new CardSensor (this);
			
			if (getType() == CardData.UNIT) {
				attackLabel = CardFormater.getLabel (cardData.getAttack());
				attackLabel.y = this.height - attackLabel.height;
				addChild (attackLabel);
			}
			
			if (getType() == CardData.UNIT) {
				healthLabel = CardFormater.getLabel (cardData.getHealth());
				healthLabel.y = attackLabel.y;
				healthLabel.x = this.width - healthLabel.width; 
				addChild (healthLabel);
			}
			
			
			titleLabel = CardFormater.getMiniTitleLabel (CARD_WIDTH, cardData.getTitle());
            titleLabel.y = Math.round (CARD_HEIGHT * 0.4);
            addChild (titleLabel);
			
		
			
			
       }
        private function formatMirror () :void {
            mirror = new Sprite();

            CardFormater.drawMirror(mirror, MIRROR_WIDTH, MIRROR_HEIGHT, getType());

            mirrorPriceLabel = CardFormater.getMirrorLabel(price);
            mirror.addChild (mirrorPriceLabel);

            mirrorAttackLabel = CardFormater.getMirrorLabel(cardData.getAttack());
            mirrorAttackLabel.y = mirror.height - mirrorAttackLabel.height;
            if (getType() == CardData.UNIT) {
                mirror.addChild (mirrorAttackLabel);
            }

            mirrorHealthLabel =  CardFormater.getMirrorLabel(cardData.getHealth());
            mirrorHealthLabel.x = mirror.width - mirrorHealthLabel.width;
            mirrorHealthLabel.y = mirrorAttackLabel.y;
            if (getType() == CardData.UNIT) {
                mirror.addChild (mirrorHealthLabel);
            }

            mirrorTitleLabel = CardFormater.getMirrorTitleLabel (MIRROR_WIDTH, cardData.getTitle());
            mirrorTitleLabel.y = Math.round (mirror.height * 0.4);
            mirror.addChild (mirrorTitleLabel);

            mirrorDescriptionLabel = CardFormater.getMirrorDescriptionLabel(MIRROR_WIDTH, 80, parseDescription(cardData.getDescription()))
            mirrorDescriptionLabel.y = Math.round (mirror.height * 0.55);
            mirror.addChild (mirrorDescriptionLabel);
			
			mirrorTypeLabel = CardFormater.getMirrorTypeLabel (MIRROR_WIDTH);
			mirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.9);
			mirror.addChild (mirrorTypeLabel);
			
			if (cardData.getSubrace()) {
				mirrorTypeLabel.text = cardData.getSubrace();
			} else if (cardData.getRace()) {
				mirrorTypeLabel.text = cardData.getRace();
			} else {
				if (cardData.getType() == CardData.UNIT) {
					mirrorTypeLabel.text = 'персонаж';
				} else if (cardData.getType() == CardData.SECRET) {
					mirrorTypeLabel.text = 'секрет';
				}
				else {
					mirrorTypeLabel.text = 'способность';
				}
			}

        }
        private function formatShirt () :void {
            shirt = new Sprite ();
            CardFormater.drawShirt(shirt, MIRROR_WIDTH, MIRROR_HEIGHT);

            smallShirt = new Sprite ();
            CardFormater.drawSmallShirt(smallShirt);
        }



		public function getCardData () :CardData {
			return cardData;
		}
		
		public function getPrice () :int {
			return price;
		}

        public function addSale (value:int) :void {
            price -= value;

            if (price < 0) {
                price = 0;
            }

            if (price < defaultPrice) {
                mirrorPriceLabel.defaultTextFormat = mirrorSaleFormat;
                priceLabel.defaultTextFormat = saleFormat;
            } else if (price > defaultPrice) {
                mirrorPriceLabel.defaultTextFormat =mirrorExpensiveFormat
                priceLabel.defaultTextFormat = expensiveFormat;
            } else {
                mirrorPriceLabel.defaultTextFormat = mirrorPriceFormat;
                priceLabel.defaultTextFormat = priceFormat;
            }
            mirrorPriceLabel.text = '' + price;
            priceLabel.text = '' + price;

        }

        public function cancelSale (value:int) :void {
            price += value;

            if (price > defaultPrice) {
                price = defaultPrice;
            }

            if (price < defaultPrice) {
                mirrorPriceLabel.defaultTextFormat = mirrorSaleFormat;
                priceLabel.defaultTextFormat = saleFormat;
            } else {
                mirrorPriceLabel.defaultTextFormat = mirrorPriceFormat;
                priceLabel.defaultTextFormat = priceFormat;
            }
            mirrorPriceLabel.text = '' + price;
            priceLabel.text = '' + price;
        }

        public function checkSpell () :void {
            var description:String = parseDescription (cardData.getDescription())
            descriptionLabel.text = description;

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

        public function getShirt () :Sprite {
            return shirt;
        }

        public function getSmallShirt () :Sprite {
            return smallShirt;
        }
		
		public function getSensor () :CardSensor {
			return cardSensor;
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