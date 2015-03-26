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
		
		private var craftTitleLabel:TextField;
		private var craftDescriptionLabel:TextField;
		private var craftPriceLabel:TextField;
		private var craftAttackLabel:TextField;
		private var craftHealthLabel:TextField;
		private var craftTypeLabel:TextField;
		private var craftBody:Sprite;
		
		private var craftMirrorTitleLabel:TextField;
		private var craftMirrorDescriptionLabel:TextField;
		private var craftMirrorPriceLabel:TextField;
		private var craftMirrorAttackLabel:TextField;
		private var craftMirrorHealthLabel:TextField;
		private var craftMirrorTypeLabel:TextField;
		private var craftMirror:Sprite;
		
		private var body:Sprite;
		
		private var state:int = 0;
			
		public function CollectionCard(cardData:CollectionCardData, showCount:Boolean = true) {
            showCountFlag = showCount;
			
			this.cardData = cardData;
            price = cardData.getPrice();
            defaultPrice = price;

            formatCard();
            formatMirror();
			
			formatCraftCard();
			formatCraftMirror();
			
			buttonMode = true;
			addEventListener (MouseEvent.CLICK, onClick); 
        }
		
		private function onClick (event:MouseEvent) :void {
			dispatchEvent (new CardEvent (CardEvent.COLLECTION_CLICK, {card:this}))
		}

        private function formatCard () :void {
            body = new Sprite();
			
			CardFormater.drawBody(body, getType(), CARD_WIDTH, CARD_HEIGHT, 25);
			addChild (body);
			
			priceLabel = CardFormater.getCollectionLabel (price);
            body.addChild (priceLabel);
			
			if (getType() == CardData.UNIT) {
				attackLabel = CardFormater.getCollectionLabel (cardData.getAttack());
				attackLabel.y = this.height - attackLabel.height;
				body.addChild (attackLabel);
			}
			
			if (getType() == CardData.UNIT) {
				healthLabel = CardFormater.getCollectionLabel (cardData.getHealth());
				healthLabel.y = attackLabel.y;
				healthLabel.x = this.width - healthLabel.width; 
				body.addChild (healthLabel);
			}
			
			titleLabel = CardFormater.getTitleLabel (CARD_WIDTH, cardData.getTitle());
            titleLabel.y = Math.round (CARD_HEIGHT * 0.4);
            body.addChild (titleLabel);
			
			descriptionLabel = CardFormater.getDescriptionLabel (CARD_WIDTH, cardData.getDescription());
			descriptionLabel.y = Math.round (CARD_HEIGHT * 0.55);
			body.addChild (descriptionLabel);
			
			typeLabel = CardFormater.getTypeLabel (CARD_WIDTH);
			typeLabel.y = Math.round (CARD_HEIGHT * 0.9);
			body.addChild (typeLabel);
			
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
			countLabel = CardFormater.getCountLabel(20);
			countLabel.y = CARD_HEIGHT;
			countLabel.x = (CARD_WIDTH - countLabel.width) / 2;
			if (cardData.getCount() > 1) {
				countLabel.text = 'x' + count;
			}
			if (showCountFlag) {
				body.addChild(countLabel);
			}
			
			blockSprite = new Sprite ();
			blockSprite.graphics.beginFill (0x222222, 0.5);
			blockSprite.graphics.drawRect (0, 0, CARD_WIDTH, CARD_HEIGHT);
			blockSprite.graphics.endFill();
			blockSprite.mouseEnabled = false;
			
		}
		
		private function formatCraftCard () :void {
			craftBody = new Sprite;
			CraftCardFormatter.drawBody(craftBody, getType(), CARD_WIDTH, CARD_HEIGHT, 25);
            
			craftPriceLabel = CraftCardFormatter.getLabel (price);
            craftBody.addChild (craftPriceLabel);
			
			if (getType() == CardData.UNIT) {
				craftAttackLabel = CraftCardFormatter.getLabel (cardData.getAttack());
				craftAttackLabel.y = craftBody.height - craftAttackLabel.height;
				craftBody.addChild (craftAttackLabel);
			}
			
			if (getType() == CardData.UNIT) {
				craftHealthLabel = CraftCardFormatter.getLabel (cardData.getHealth());
				craftHealthLabel.y = craftAttackLabel.y;
				craftHealthLabel.x = craftBody.width - craftHealthLabel.width; 
				craftBody.addChild (craftHealthLabel);
			}
			
			
			craftTitleLabel = CraftCardFormatter.getTitleLabel (CARD_WIDTH, cardData.getTitle());
            craftTitleLabel.y = Math.round (CARD_HEIGHT * 0.4);
            craftBody.addChild (craftTitleLabel);
			
			craftDescriptionLabel = CraftCardFormatter.getDescriptionLabel (CARD_WIDTH, cardData.getDescription());
			craftDescriptionLabel.y = Math.round (CARD_HEIGHT * 0.55);
			craftBody.addChild (craftDescriptionLabel);
						
			craftTypeLabel = CraftCardFormatter.getTypeLabel (CARD_WIDTH);
			craftTypeLabel.y = Math.round (CARD_HEIGHT * 0.9);
			craftBody.addChild (craftTypeLabel);
			
			if (cardData.getSubrace()) {
				craftTypeLabel.text = cardData.getSubrace();
			} else if (cardData.getRace()) {
				craftTypeLabel.text = cardData.getRace();
			} else {
				if (cardData.getType() == CardData.UNIT) {
					craftTypeLabel.text = 'персонаж';
				} else if (cardData.getType() == CardData.SECRET) {
					craftTypeLabel.text = 'секрет';
				}
				else {
					craftTypeLabel.text = 'способность';
				}
			}
			
			
		}
		
		private function formatCraftMirror () :void {
			craftMirror = new Sprite();
            CraftCardFormatter.drawMirror(craftMirror, MIRROR_WIDTH, MIRROR_HEIGHT, cardData.getType(), 40);

            craftMirrorPriceLabel = CraftCardFormatter.getMirrorLabel(price);
			craftMirror.addChild (craftMirrorPriceLabel);

            craftMirrorAttackLabel = CraftCardFormatter.getMirrorLabel(cardData.getAttack());
            craftMirrorAttackLabel.y = craftMirror.height - 40;
            if (getType() == CardData.UNIT) {
                craftMirror.addChild (craftMirrorAttackLabel);
            }

            craftMirrorHealthLabel =  CraftCardFormatter.getMirrorLabel(cardData.getHealth());
            craftMirrorHealthLabel.x = craftMirror.width - 40;
            craftMirrorHealthLabel.y = craftMirrorAttackLabel.y;
            if (getType() == CardData.UNIT) {
                craftMirror.addChild (craftMirrorHealthLabel);
            }

			
            craftMirrorTitleLabel = CraftCardFormatter.getMirrorTitleLabel (MIRROR_WIDTH, cardData.getTitle());
            craftMirrorTitleLabel.y = Math.round (craftMirror.height * 0.4);
            craftMirror.addChild (craftMirrorTitleLabel);

            craftMirrorDescriptionLabel = CraftCardFormatter.getMirrorDescriptionLabel(MIRROR_WIDTH, parseDescription(cardData.getDescription()))
            craftMirrorDescriptionLabel.y = Math.round (craftMirror.height * 0.55);
            craftMirror.addChild (craftMirrorDescriptionLabel);
			
			
			craftMirrorTypeLabel = CraftCardFormatter.getMirrorTypeLabel (MIRROR_WIDTH);
			craftMirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.92);
			craftMirror.addChild (craftMirrorTypeLabel);
			
			if (cardData.getSubrace()) {
				craftMirrorTypeLabel.text = cardData.getSubrace();
			} else if (cardData.getRace()) {
				craftMirrorTypeLabel.text = cardData.getRace();
			} else {
				if (cardData.getType()) {
					craftMirrorTypeLabel.text = 'персонаж';
				} else {
					craftMirrorTypeLabel .text = 'способность';
				}
			}
			
		}
		
		public function setState (state:int) :void {
			this.state = state;
			while (this.numChildren) this.removeChildAt (0);

			if (state) {
				addChild (craftBody);
			} else {
				addChild (body);
			}
		}
		
		public function increment () :void {
			
			count ++
						
			if (countLabel) {
				countLabel.text = 'x' + cardData.getCount();
				if (count > 1) {
					body.addChild (countLabel);
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
					if (body.contains(countLabel)) body.removeChild (countLabel);
				} 
			}
						
			if (count <= 0) {
				block();
			}
		}
		
		public function showCount () :void {
			count = cardData.getCount();
			if (countLabel) {
				countLabel.text = 'x' + count;
				if (count > 1) {
					body.addChild (countLabel);
				} else {
					if (body.contains(countLabel)) {
						body.removeChild (countLabel);
					}
				}
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
			if (state) {
				return craftMirror;
			} else {
				return mirror;
			}
			
		}
		
		public function getMirrorBitmap () :Bitmap {
			if (state) {
				return getBitmapCopy(craftMirror);
			} else {
				return getBitmapCopy(mirror);
			}
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