package com.sla.mvc.view.card 
{
	import com.sla.mvc.model.data.CardData;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import ru.flasher.utils.StringUtil;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Card extends Sprite 
	{
		[Embed(source = "../../../../../../lib/assets/cardMirrorTexture.png")]
		private var MirrorAsset:Class;
		
		[Embed(source="../../../../../../lib/assets/cardTexture.png")]
		private var CardAsset:Class;
		
		[Embed(source = "../../../../../../lib/assets/cardMirrorSpellTexture.png")]
		private var MirrorSpellAsset:Class;
		
		[Embed(source = "../../../../../../lib/assets/cardSpellTexture.png")]
		private var CardSpellAsset:Class;
		
		[Embed(source = "../../../../../../lib/assets/cardShirt.png")]
		private var ShirtClass:Class;
		
		[Embed(source = "../../../../../../lib/assets/cardMirrorShirt.png")]
		private var MirrorShirtClass:Class;
		
		public static const DEFAULT_GLOW_COLOR:int = 0x00FFFF;
		public static const SERIES_GLOW_COLOR:int = 0xFFFF00;
		
		public static const MIRROR_WIDTH:int = 154;
		public static const MIRROR_HEIGHT:int = 224;
		
		public static const CARD_WIDTH:int = 110;
		public static const CARD_HEIGHT:int = 160;
		
		private var cardData:CardData;
		
		private var mirror:Sprite;
		//private var cardSensor:CardSensor;
		
		private var shirt:Sprite;
		private var smallShirt:Sprite;

        private var price:int;
        private var defaultPrice:int;
		
		private var glowColor:int = 0x00FFFF;
		
		private var priceLabel:Label;
		private var attackLabel:Label;
		private var healthLabel:Label;
		private var titleLabel:Label;
		private var descriptionArea:TextArea;
		private var typeLabel:Label;
		
		private var mirrorPriceLabel:Label;
		private var mirrorAttackLabel:Label;
		private var mirrorHealthLabel:Label;
		private var mirrorTitleLabel:Label;
		private var mirrorDescriptionArea:TextArea;
		private var mirrorTypeLabel:Label;
		
		private var _position:Point;
		private var _longPosition:Point;
		
		private var cardSensor:CardSensor;
		private var cardContainer:Sprite;
		
		private var _block:Boolean = false;
		
		private var _endRotation:Number;
		
		
		public function Card(cardData:CardData)
		{
			this.cardData = cardData;
			price = cardData.price;
            defaultPrice = price;
			
			formatCard();
            formatMirror();
           	formatShirt();
			setSpellMixin(0);
			
			
			
			// уточняем есть ли у карты способность пассивной аттаки по нескольким существам.
			//validateSeveralTargetsEptitude();
			
			//уточняем есть ли у карты способности которые улучшаются при серии приемов
			//validateDrawingSeries();
			
			
		}
		
		public function set block (value:Boolean) :void {
			this._block = value;
		}
		
		public function get block () :Boolean {
			return _block;
		}
		
		public function set endRotation (value:Number) :void {
			this._endRotation = value;
		}
		
		public function get endRotation () :Number {
			return _endRotation;
		}
		
		public function set position (value:Point) :void {
			this._position = value;
		}
		public function get position () :Point {
			return _position;
		}
		
		public function set longPosition (value:Point) :void {
			this._longPosition = value;
		}
		public function get longPosition () :Point {
			return _longPosition;
		}
		
		public function getCardData() :CardData {
			return cardData;
		}
		
		public function get sensor () :CardSensor {
			return cardSensor;
		}
		
		
		
		private function formatCard () :void {
			cardSensor = new CardSensor (this);
			cardContainer = new Sprite;
			addChild(cardContainer);
			cardContainer.x -= CARD_WIDTH / 2;
			cardContainer.y -= CARD_HEIGHT / 2;
			//container.
			var asset:Bitmap
			if (cardData.type == CardData.UNIT) {
				asset = new CardAsset();
			} else {
				asset = new CardSpellAsset();
			}
			var texture:Texture = Texture.fromBitmap(asset);
			var body:Image = new Image(texture); //CardFormater.drawBody(CARD_WIDTH, CARD_HEIGHT, cardData.type, 21);
			cardContainer.addChild(body);
			
			priceLabel = CardFormater.drawValueLabel(price.toString());
			priceLabel.width = 18;
			priceLabel.height = 18;
			priceLabel.x += 2;
			priceLabel.y += 1;
			cardContainer.addChild(priceLabel);
			
			if (cardData.type == CardData.UNIT) {
				attackLabel = CardFormater.drawValueLabel(cardData.attack.toString());
				attackLabel.width = 18;
				attackLabel.height = 18;
				attackLabel.x += 2;
				attackLabel.y = CARD_HEIGHT - attackLabel.height;
				attackLabel.y -= 3;
				cardContainer.addChild(attackLabel);
				
				healthLabel = CardFormater.drawValueLabel(cardData.health.toString());
				healthLabel.width = 18;
				healthLabel.height = 18;
				healthLabel.y = attackLabel.y;
				healthLabel.x = CARD_WIDTH - healthLabel.width;
				healthLabel.x -= 2;
				cardContainer.addChild(healthLabel);
			}
			
			titleLabel = CardFormater.drawTitleLabel(cardData.title.toString());
			titleLabel.width = CARD_WIDTH - 6;
			titleLabel.x = 0;
			titleLabel.y = Math.round (this.height * 0.47);
			cardContainer.addChild (titleLabel);

			descriptionArea = CardFormater.drawDescriptionArea(parseDescription(cardData.description));
			descriptionArea.width = CARD_WIDTH - 20;
			descriptionArea.x = 10;
			descriptionArea.height = 40;
			descriptionArea.y = Math.round (this.height * 0.57);
            cardContainer.addChild (descriptionArea);
			
			typeLabel = CardFormater.drawTypeLabel ();
			typeLabel.y = Math.round (this.height * 0.9);
			typeLabel.width = CARD_WIDTH;
			cardContainer.addChild (typeLabel);
			
			if (cardData.subrace) {
				typeLabel.text = cardData.subrace;
			} else if (cardData.race) {
				typeLabel.text = cardData.race;
			} else {
				if (cardData.type == CardData.UNIT) {
					typeLabel.text = 'персонаж';
				} else if (cardData.type == CardData.SECRET) {
					typeLabel.text = 'секрет';
				}
				else {
					typeLabel.text = 'способность';
				}
			}
			hideDescription ();
		}
		
		
		
		private function formatMirror () :void {
			mirror = new Sprite();
			var container:Sprite = new Sprite;
			mirror.addChild(container);
			container.x -= MIRROR_WIDTH/2;
			container.y -= MIRROR_HEIGHT/2;
			var asset:Bitmap
			if (cardData.type == CardData.UNIT) {
				asset = new MirrorAsset();
			} else {
				asset = new MirrorSpellAsset();
			}
			var texture:Texture = Texture.fromBitmap(asset);
			var body:Image = new Image(texture);
			//var body:QuadBatch = CardFormater.drawBody(MIRROR_WIDTH, MIRROR_HEIGHT, cardData.type, 30);
			container.addChild(body);
			
			mirrorPriceLabel = CardFormater.drawMirrorValueLabel(price.toString());
            mirrorPriceLabel.width = 31;
			mirrorPriceLabel.height = 31;
			//mirrorPriceLabel.y -= 2;
			container.addChild (mirrorPriceLabel);

            
			mirrorAttackLabel = CardFormater.drawMirrorValueLabel(cardData.attack.toString());
            mirrorAttackLabel.width = 31;
			mirrorAttackLabel.height = 31;
			mirrorAttackLabel.y = mirror.height - mirrorAttackLabel.height;
            mirrorAttackLabel.y -= 3;
			if (cardData.type == CardData.UNIT) {
                container.addChild (mirrorAttackLabel);
            }

            mirrorHealthLabel =  CardFormater.drawMirrorValueLabel(cardData.health.toString());
            mirrorHealthLabel.width = 31;
			mirrorHealthLabel.height = 31;
			mirrorHealthLabel.x = mirror.width - mirrorHealthLabel.width;
			mirrorHealthLabel.x  -= 2;
            mirrorHealthLabel.y = mirrorAttackLabel.y;
			if (cardData.type == CardData.UNIT) {
                container.addChild (mirrorHealthLabel);
            }

            
			mirrorTitleLabel = CardFormater.drawMirrorTitleLabel (cardData.title);
            mirrorTitleLabel.width = Card.MIRROR_WIDTH - 10;
			mirrorTitleLabel.x = 5;
			mirrorTitleLabel.y = Math.round (mirror.height * 0.45);
			container.addChild (mirrorTitleLabel);

            mirrorDescriptionArea = CardFormater.drawMirrorDescriptionArea(parseDescription(cardData.description))
            mirrorDescriptionArea.width = Card.MIRROR_WIDTH - 20;
			mirrorDescriptionArea.x = 10;
			mirrorDescriptionArea.height = 80;
			mirrorDescriptionArea.y = Math.round (mirror.height * 0.55);
            container.addChild (mirrorDescriptionArea);
			
			
			mirrorTypeLabel = CardFormater.drawMirrorTypeLabel ();
			mirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.9);
			mirrorTypeLabel.width = Card.MIRROR_WIDTH;
			container.addChild (mirrorTypeLabel);
			
			if (cardData.subrace) {
				mirrorTypeLabel.text = cardData.subrace;
			} else if (cardData.race) {
				mirrorTypeLabel.text = cardData.race;
			} else {
				if (cardData.type == CardData.UNIT) {
					mirrorTypeLabel.text = 'персонаж';
				} else if (cardData.type == CardData.SECRET) {
					mirrorTypeLabel.text = 'секрет';
				}
				else {
					mirrorTypeLabel.text = 'способность';
				}
			}
			
		}
		
		private function parseDescription (str:String) :String {
            var spellBob:int = 0;
            var spellPower:int = cardData.spellPower + spellBob;
            var result:String = StringUtil.format(str, spellPower);
            return result;
        }
		
		private function formatShirt () :void {
			shirt = new Sprite();
			var container:Sprite = new Sprite;
			shirt.addChild(container);
			
			container.x -= Card.MIRROR_WIDTH/2;
			container.y -= Card.MIRROR_HEIGHT/2;
			
			var mirrorShirtAsset:Bitmap = new MirrorShirtClass();
			var mirrorShirtTexture:Texture = Texture.fromBitmap(mirrorShirtAsset); 
			var mirrorShirtImage:Image = new Image(mirrorShirtTexture);
			container.addChild(mirrorShirtImage);
			
			smallShirt = new Sprite();
			smallShirt.x -= Card.CARD_WIDTH/2;
			smallShirt.y -= Card.CARD_HEIGHT / 2;
			
			var shirtAsset:Bitmap = new ShirtClass();
			var shirtTexture:Texture = Texture.fromBitmap(shirtAsset); 
			var shirtImage:Image = new Image(shirtTexture);
			smallShirt.addChild(shirtImage);
		}
		
		public function getShirt () :Sprite {
			return shirt;
		}
		
		public function set shirtMode (value:Boolean) :void {
			removeChildren();
			if (value) {
				addChild(smallShirt);
			} else {
				addChild(cardContainer);
			}
			
		}
		
		public function glow () :void {
			this.filter = Card.glowFilter;
		}
		
		public function stopGlow () :void {
			this.filter = null;
		}
		
		public function getMirror () :Sprite {
			return mirror;
		}
		
		public function glowMirror () :void {
            this.filter = Card.glowFilter;
			//getMirror().filters = [new GlowFilter (0x00FFFF)];
        }

        public function stopGlowMirror () :void {
           this.filter = null;
        }
		
		private static var _glowWilter:BlurFilter;
		private static function get glowFilter () :BlurFilter {
			if (!_glowWilter) {
				_glowWilter = BlurFilter.createGlow(0x00FFFF, 1, 3, .5);
				_glowWilter
			}
			return _glowWilter;
		}
		
		public function hideDescription () :void {
			if (attackLabel) {
				attackLabel.visible = false;
			}
			if (healthLabel) {
				healthLabel.visible = false;
			}
			descriptionArea.visible = false;
			typeLabel.visible = false;
		}
		
		public function showDescription () :void {
			if (attackLabel) {
				attackLabel.visible = true;
			}
			if (healthLabel) {
				healthLabel.visible = true;
			}
			descriptionArea.visible = true;
			typeLabel.visible = true;
		}
		
		public function setSpellMixin (value:int) :void {
			var list:Array = cardData.description.split('&')
			if (list.length > 1) {
				var str:String = '' 

				for (var i:int = 0; i < list.length; i ++) {
					if (isEven(i)) {
						str = str.concat(int(list[i]) + value)
					} else {
						str = str.concat(list[i])
					}
				}
				descriptionArea.text = str;
				mirrorDescriptionArea.text = str;
			}
		}
		private function isEven(value:int):Boolean
		{
			//check if the number is odd or even
			if (value % 2 == 0)
			{
				return false;
			}
			else
			{
				return true;
			}
		}

		
	}

}