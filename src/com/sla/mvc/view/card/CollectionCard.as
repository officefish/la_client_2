package com.sla.mvc.view.card 
{
	import com.sla.event.starling.StarlingCollectionEvent;
	import com.sla.mvc.model.data.CardData;
	import com.sla.mvc.model.data.CollectionCardData;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import flash.display.Bitmap;
	import ru.flasher.utils.StringUtil;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CollectionCard extends Sprite 
	{
		
		[Embed(source="../../../../../../lib/assets/collectionCardMirrorTexture.png")]
		private static var MirrorAsset:Class;
		private static var _mirrorAssetTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCardTexture.png")]
		private static var CardAsset:Class;
		private static var _cardAssetTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCardSpellMirrorTexture.png")]
		private static var MirrorSpellAsset:Class;
		private static var _mirrorSpellTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCardSpellTexture.png")]
		private static var CardSpellAsset:Class;
		private static var _cardSpellTexture:Texture;
		
		//
		
		[Embed(source="../../../../../../lib/assets/collectionCraftCardMirrorTexture.png")]
		private static var CraftMirrorAsset:Class;
		private static var _craftMirrorAssetTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCraftCardTexture.png")]
		private static var CraftCardAsset:Class;
		private static var _craftCardAssetTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCraftCardSpellMirrorTexture.png")]
		private static var CraftMirrorSpellAsset:Class;
		private static var _craftMirrorSpellTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCraftCardSpellTexture.png")]
		private static var CraftCardSpellAsset:Class;
		private static var _craftCardSpellTexture:Texture;
		
		//
		
		
		[Embed(source = "../../../../../../lib/assets/cardShirt.png")]
		private var ShirtClass:Class;
		
		[Embed(source = "../../../../../../lib/assets/cardMirrorShirt.png")]
		private var MirrorShirtClass:Class;
		
		public static const CARD_WIDTH:int = 136;
		public static const CARD_HEIGHT:int = 190;
		
		public static const MIRROR_WIDTH:int = 250;
		public static const MIRROR_HEIGHT:int = 350;
		
		private var price:int;
		private var defaultPrice:int;
		
		
		private var cardData:CollectionCardData;
		
		private var cardContainer:Sprite;
		private var craftCardContainer:Sprite;
		private var mirrorContainer:Sprite;
		private var craftMirrorContainer:Sprite;
		
		private var priceLabel:Label;
		private var attackLabel:Label;
		private var healthLabel:Label;
		private var titleLabel:Label;
		private var descriptionArea:TextArea; 
		private var typeLabel:Label;
		private var countLabel:Label;
		
		private var mirrorPriceLabel:Label;
		private var mirrorAttackLabel:Label;
		private var mirrorHealthLabel:Label;
		private var mirrorTitleLabel:Label;
		private var mirrorDescriptionArea:TextArea; 
		private var mirrorTypeLabel:Label;
		
		private var craftPriceLabel:Label;
		private var craftAttackLabel:Label;
		private var craftHealthLabel:Label;
		private var craftTitleLabel:Label;
		private var craftDescriptionArea:TextArea; 
		private var craftTypeLabel:Label;
		
		private var craftMirrorPriceLabel:Label;
		private var craftMirrorAttackLabel:Label;
		private var craftMirrorHealthLabel:Label;
		private var craftMirrorTitleLabel:Label;
		private var craftMirrorDescriptionArea:TextArea; 
		private var craftMirrorTypeLabel:Label;
		
		
		private var _mirror:Sprite;
		private var _craftMirror:Sprite;
		
		private var count:int;
		private var blockQuad:Quad;
		
		private var blockFlag:Boolean;
		
		private var state:int = 0;
		
		public function CollectionCard(cardData:CollectionCardData) 
		{
			super();
			
			this.cardData = cardData;
            price = cardData.price;
            defaultPrice = price;
			
			formatCard();
            formatMirror();
			
			formatCraftCard();
			formatCraftMirror();
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			this.useHandCursor = true;
		}
		
		public function getCardData () :CollectionCardData {
			return this.cardData;
		}
		
		private static function get mirrorAssetTexture ():Texture {
			if (!_mirrorAssetTexture) {
				_mirrorAssetTexture = Texture.fromBitmap(new MirrorAsset());
			}
			return _mirrorAssetTexture;
		}
		
		private static function get cardAssetTexture ():Texture {
			if (!_cardAssetTexture) {
				_cardAssetTexture = Texture.fromBitmap(new CardAsset());
			}
			return _cardAssetTexture;
		}
		
		private static function get mirrorSpellTexture () :Texture {
			if (!_mirrorSpellTexture) {
				_mirrorSpellTexture = Texture.fromBitmap(new MirrorSpellAsset());
			}
			return _mirrorSpellTexture;
		}
		
		private static function get cardSpellTexture () :Texture {
			if (!_cardSpellTexture) {
				_cardSpellTexture = Texture.fromBitmap(new CardSpellAsset());
			}
			return _cardSpellTexture;
		}
		
		//
		
		private static function get craftMirrorAssetTexture ():Texture {
			if (!_craftMirrorAssetTexture) {
				_craftMirrorAssetTexture = Texture.fromBitmap(new CraftMirrorAsset());
			}
			return _craftMirrorAssetTexture;
		}
		
		private static function get craftCardAssetTexture ():Texture {
			if (!_craftCardAssetTexture) {
				_craftCardAssetTexture = Texture.fromBitmap(new CraftCardAsset());
			}
			return _craftCardAssetTexture;
		}
		
		private static function get craftMirrorSpellTexture () :Texture {
			if (!_craftMirrorAssetTexture) {
				_craftMirrorAssetTexture = Texture.fromBitmap(new CraftMirrorSpellAsset());
			}
			return _craftMirrorAssetTexture;
		}
		
		private static function get craftCardSpellTexture () :Texture {
			if (!_craftCardSpellTexture) {
				_craftCardSpellTexture = Texture.fromBitmap(new CraftCardSpellAsset);
			}
			return _craftCardSpellTexture;
		}
		
		private function formatCard () :void {
			cardContainer = new Sprite;
			addChild(cardContainer);
			cardContainer.x -= CARD_WIDTH / 2;
			cardContainer.y -= CARD_HEIGHT / 2;
			//container.
			var texture:Texture
			if (cardData.type == CardData.UNIT) {  
				texture = CollectionCard.cardAssetTexture;
			} else {
				texture = CollectionCard.cardSpellTexture;
			}
			var body:Image = new Image(texture); 
			cardContainer.addChild(body);
			
			priceLabel = CardFormater.drawCollectionValueLabel(price.toString());
			priceLabel.width = 28;
			priceLabel.height = 28;
			priceLabel.x += 2;
			priceLabel.y += 2;
			cardContainer.addChild(priceLabel);
			
			if (cardData.type == CardData.UNIT) {
				attackLabel = CardFormater.drawCollectionValueLabel(cardData.attack.toString());
				attackLabel.width = 28;
				attackLabel.height = 28;
				attackLabel.x += 2;
				attackLabel.y = CARD_HEIGHT - attackLabel.height;
				attackLabel.y -= 3;
				cardContainer.addChild(attackLabel);
				
				healthLabel = CardFormater.drawCollectionValueLabel(cardData.health.toString());
				healthLabel.width = 28;
				healthLabel.height = 28;
				healthLabel.y = attackLabel.y;
				healthLabel.x = CARD_WIDTH - healthLabel.width;
				healthLabel.x -= 2;
				cardContainer.addChild(healthLabel);
			}
			
			titleLabel = CardFormater.drawCollectionTitleLabel(cardData.title.toString());
			titleLabel.width = CARD_WIDTH - 6;
			titleLabel.x = 0;
			titleLabel.y = Math.round (this.height * 0.45);
			cardContainer.addChild (titleLabel);
			
			descriptionArea = CardFormater.drawCollectionDescriptionArea(parseDescription(cardData.description));
			descriptionArea.width = CARD_WIDTH - 20;
			descriptionArea.x = 10;
			descriptionArea.height = 50;
			descriptionArea.y = Math.round (this.height * 0.55);
            cardContainer.addChild (descriptionArea);
			
			typeLabel = CardFormater.drawCollectionTypeLabel ();
			typeLabel.y = Math.round (this.height * 0.88);
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
			
			count = cardData.getCount();
			countLabel = CardFormater.drawCollectionCountLabel(20);
			countLabel.y = CARD_HEIGHT;
			countLabel.x = (CARD_WIDTH - countLabel.width) / 2;
			if (cardData.getCount() > 1) {
				countLabel.text = 'x' + count;
			}
			cardContainer.addChild(countLabel);
			
			blockQuad = new Quad (CARD_WIDTH, CARD_HEIGHT, 0x222222);
			blockQuad.alpha = 0.5;
			
		}
		
		public function showCount () :void {
			count = cardData.getCount();
			if (countLabel) {
				countLabel.text = 'x' + count;
				if (count > 1) {
					cardContainer.addChild(countLabel);
				} else {
					if (cardContainer.contains(countLabel)) {
						cardContainer.removeChild(countLabel);
					}
				}
			}
		}
		
		private function formatCraftCard () :void {
			
			craftCardContainer = new Sprite;
			craftCardContainer.x -= CARD_WIDTH / 2;
			craftCardContainer.y -= CARD_HEIGHT / 2;
			//container.
			var texture:Texture
			if (cardData.type == CardData.UNIT) {  
				texture = CollectionCard.craftCardAssetTexture;
			} else {
				texture = CollectionCard.craftCardSpellTexture;
			}
			var body:Image = new Image(texture); 
			craftCardContainer.addChild(body);
			
			craftPriceLabel = CardFormater.drawCraftCollectionValueLabel(price.toString());
			craftPriceLabel.width = 28;
			craftPriceLabel.height = 28;
			craftPriceLabel.x += 2;
			craftPriceLabel.y += 2;
			craftCardContainer.addChild(craftPriceLabel);
			
			if (cardData.type == CardData.UNIT) {
				craftAttackLabel = CardFormater.drawCraftCollectionValueLabel(cardData.attack.toString());
				craftAttackLabel.width = 28;
				craftAttackLabel.height = 28;
				craftAttackLabel.x += 2;
				craftAttackLabel.y = CARD_HEIGHT - craftAttackLabel.height;
				craftAttackLabel.y -= 3;
				craftCardContainer.addChild(craftAttackLabel);
				
				craftHealthLabel = CardFormater.drawCraftCollectionValueLabel(cardData.health.toString());
				craftHealthLabel.width = 28;
				craftHealthLabel.height = 28;
				craftHealthLabel.y = attackLabel.y;
				craftHealthLabel.x = CARD_WIDTH - craftHealthLabel.width;
				craftHealthLabel.x -= 2;
				craftCardContainer.addChild(craftHealthLabel);
			}
			
			craftTitleLabel = CardFormater.drawCraftCollectionTitleLabel(cardData.title.toString());
			craftTitleLabel.width = CARD_WIDTH - 6;
			craftTitleLabel.x = 0;
			craftTitleLabel.y = Math.round (this.height * 0.45);
			craftCardContainer.addChild (craftTitleLabel);
			
			craftDescriptionArea = CardFormater.drawCraftCollectionDescriptionArea(parseDescription(cardData.description));
			craftDescriptionArea.width = CARD_WIDTH - 20;
			craftDescriptionArea.x = 10;
			craftDescriptionArea.height = 50;
			craftDescriptionArea.y = Math.round (this.height * 0.55);
            craftCardContainer.addChild (craftDescriptionArea);
			
			craftTypeLabel = CardFormater.drawCraftCollectionTypeLabel ();
			craftTypeLabel.y = Math.round (this.height * 0.88);
			craftTypeLabel.width = CARD_WIDTH;
			craftCardContainer.addChild (craftTypeLabel);
			
			if (cardData.subrace) {
				craftTypeLabel.text = cardData.subrace;
			} else if (cardData.race) {
				craftTypeLabel.text = cardData.race;
			} else {
				if (cardData.type == CardData.UNIT) {
					craftTypeLabel.text = 'персонаж';
				} else if (cardData.type == CardData.SECRET) {
					craftTypeLabel.text = 'секрет';
				}
				else {
					craftTypeLabel.text = 'способность';
				}
			}
		}
		
		public function setState (state:int) :void {
			this.state = state;
			removeChildren();
			
			if (state) {
				addChild (craftCardContainer);
			} else {
				addChild (cardContainer);
			}
		}
		
		public function getId () :int {
			return cardData.getId();
		}
		
		public function getDeckSlotData () :Object {
			var data:Object = { };
			data.title = cardData.title;
			data.price = cardData.price;
			data.id = cardData.getId();
			return data;
		}
		
		private function formatMirror () :void {
			_mirror = new Sprite();
			
			mirrorContainer = new Sprite ();
			mirrorContainer.useHandCursor = true;
			
			mirrorContainer.x -= MIRROR_WIDTH / 2;
			mirrorContainer.y -= MIRROR_HEIGHT / 2;
			_mirror.addChild(mirrorContainer)
			//container.
			var asset:Bitmap 
			var texture:Texture
			if (cardData.type == CardData.UNIT) {  
				texture = CollectionCard.mirrorAssetTexture;
			} else {
				texture = CollectionCard.mirrorSpellTexture;
			}
			var body:Image = new Image(texture); 
			mirrorContainer.addChild(body);
			
			mirrorPriceLabel = CardFormater.drawCollectionMirrorValueLabel(price.toString());
			mirrorPriceLabel.width = 50;
			mirrorPriceLabel.height = 50;
			mirrorPriceLabel.x += 4;
			mirrorPriceLabel.y += 6;
			mirrorContainer.addChild(mirrorPriceLabel);
			
			if (cardData.type == CardData.UNIT) {
				mirrorAttackLabel = CardFormater.drawCollectionMirrorValueLabel(cardData.attack.toString());
				mirrorAttackLabel.width = 50;
				mirrorAttackLabel.height = 50;
				mirrorAttackLabel.x += 4;
				mirrorAttackLabel.y = MIRROR_HEIGHT - mirrorAttackLabel.height;
				mirrorAttackLabel.y -= 6;
				mirrorContainer.addChild(mirrorAttackLabel);
				
				mirrorHealthLabel = CardFormater.drawCollectionMirrorValueLabel(cardData.health.toString());
				mirrorHealthLabel.width = 50;
				mirrorHealthLabel.height = 50;
				mirrorHealthLabel.y = mirrorAttackLabel.y;
				mirrorHealthLabel.x = MIRROR_WIDTH - mirrorHealthLabel.width;
				mirrorHealthLabel.x -= 5;
				mirrorContainer.addChild(mirrorHealthLabel);
			}
			
			mirrorTitleLabel = CardFormater.drawCollectionMirrorTitleLabel(cardData.title.toString());
			mirrorTitleLabel.width = MIRROR_WIDTH - 20;
			mirrorTitleLabel.x = 10;
			mirrorTitleLabel.y = Math.round (MIRROR_HEIGHT * 0.45);
			mirrorContainer.addChild (mirrorTitleLabel);
			
			mirrorDescriptionArea = CardFormater.drawCollectionMirrorDescriptionArea(parseDescription(cardData.description));
			mirrorDescriptionArea.width = MIRROR_WIDTH - 50;
			mirrorDescriptionArea.x = 25;
			mirrorDescriptionArea.height = 90;
			mirrorDescriptionArea.y = Math.round (MIRROR_HEIGHT * 0.57);
            mirrorContainer.addChild (mirrorDescriptionArea);
			
			mirrorTypeLabel = CardFormater.drawCollectionMirrorTypeLabel ();
			mirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.90);
			mirrorTypeLabel.width = MIRROR_WIDTH;
			mirrorContainer.addChild (mirrorTypeLabel);
			
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
		
		private function formatCraftMirror () :void {
			_craftMirror = new Sprite();
			
			craftMirrorContainer = new Sprite ();
			craftMirrorContainer.useHandCursor = true;
			
			craftMirrorContainer.x -= MIRROR_WIDTH / 2;
			craftMirrorContainer.y -= MIRROR_HEIGHT / 2;
			_craftMirror.addChild(craftMirrorContainer);
			//container.
			var asset:Bitmap 
			var texture:Texture
			if (cardData.type == CardData.UNIT) {  
				texture = CollectionCard.craftMirrorAssetTexture;
			} else {
				texture = CollectionCard.craftMirrorSpellTexture;
			}
			var body:Image = new Image(texture); 
			craftMirrorContainer.addChild(body);
			
			craftMirrorPriceLabel = CardFormater.drawCraftCollectionMirrorValueLabel(price.toString());
			craftMirrorPriceLabel.width = 50;
			craftMirrorPriceLabel.height = 50;
			craftMirrorPriceLabel.x += 4;
			craftMirrorPriceLabel.y += 6;
			craftMirrorContainer.addChild(craftMirrorPriceLabel);
			
			if (cardData.type == CardData.UNIT) {
				craftMirrorAttackLabel = CardFormater.drawCraftCollectionMirrorValueLabel(cardData.attack.toString());
				craftMirrorAttackLabel.width = 50;
				craftMirrorAttackLabel.height = 50;
				craftMirrorAttackLabel.x += 4;
				craftMirrorAttackLabel.y = MIRROR_HEIGHT - mirrorAttackLabel.height;
				craftMirrorAttackLabel.y -= 6;
				craftMirrorContainer.addChild(craftMirrorAttackLabel);
				
				craftMirrorHealthLabel = CardFormater.drawCraftCollectionMirrorValueLabel(cardData.health.toString());
				craftMirrorHealthLabel.width = 50;
				craftMirrorHealthLabel.height = 50;
				craftMirrorHealthLabel.y = mirrorAttackLabel.y;
				craftMirrorHealthLabel.x = MIRROR_WIDTH - mirrorHealthLabel.width;
				craftMirrorHealthLabel.x -= 5;
				craftMirrorContainer.addChild(craftMirrorHealthLabel);
			}
			
			craftMirrorTitleLabel = CardFormater.drawCraftCollectionMirrorTitleLabel(cardData.title.toString());
			craftMirrorTitleLabel.width = MIRROR_WIDTH - 20;
			craftMirrorTitleLabel.x = 10;
			craftMirrorTitleLabel.y = Math.round (MIRROR_HEIGHT * 0.45);
			craftMirrorContainer.addChild (craftMirrorTitleLabel);
			
			craftMirrorDescriptionArea = CardFormater.drawCraftCollectionMirrorDescriptionArea(parseDescription(cardData.description));
			craftMirrorDescriptionArea.width = MIRROR_WIDTH - 50;
			craftMirrorDescriptionArea.x = 25;
			craftMirrorDescriptionArea.height = 90;
			craftMirrorDescriptionArea.y = Math.round (MIRROR_HEIGHT * 0.57);
            craftMirrorContainer.addChild (craftMirrorDescriptionArea);
			
			craftMirrorTypeLabel = CardFormater.drawCraftCollectionMirrorTypeLabel ();
			craftMirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.90);
			craftMirrorTypeLabel.width = MIRROR_WIDTH;
			craftMirrorContainer.addChild (craftMirrorTypeLabel);
			
			if (cardData.subrace) {
				craftMirrorTypeLabel.text = cardData.subrace;
			} else if (cardData.race) {
				craftMirrorTypeLabel.text = cardData.race;
			} else {
				if (cardData.type == CardData.UNIT) {
					craftMirrorTypeLabel.text = 'персонаж';
				} else if (cardData.type == CardData.SECRET) {
					craftMirrorTypeLabel.text = 'секрет';
				}
				else {
					craftMirrorTypeLabel.text = 'способность';
				}
			}
		}
		
		public function get mirror () :Sprite {
			if (state) {
				return _craftMirror;
			} else {
				return _mirror;
			}
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (event.getTouch(this, TouchPhase.BEGAN)) 
			{
				dispatchEvent(new StarlingCollectionEvent (StarlingCollectionEvent.PREVIEW, false, {'card':event.currentTarget} ))			
			}
		}
		
		
		
		private function parseDescription (str:String) :String {
            var spellBob:int = 0;
            var spellPower:int = cardData.spellPower + spellBob;
            var result:String = StringUtil.format(str, spellPower);
            return result; 
        }
		
		public function increment () :void {
			
			count ++;
			if (countLabel) {
				countLabel.text = 'x' + cardData.getCount();
				if (count > 1) {
					cardContainer.addChild (countLabel);
				}
			}
			if (count > 0) {
				unblock();
			}
		}
		
		public function decrement () :void {
			count --;
			if (countLabel) {
				countLabel.text = 'x' + cardData.getCount();
				if (count < 2) {
					if (cardContainer.contains(countLabel)) cardContainer.removeChild (countLabel);
				} 
			}
			if (count <= 0) {
				block();
			}
		}
		
		public function block () :void {
			blockFlag = true;
			cardContainer.addChild (blockQuad);
		}
		
		public function unblock () :void {
			blockFlag = false;
			if (contains(blockQuad)) {
				cardContainer.removeChild (blockQuad);
			}
		}
		
		public function get isBlocked () :Boolean {
			return blockFlag;
		}
	}

}