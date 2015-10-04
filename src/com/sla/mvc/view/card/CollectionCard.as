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
		private var MirrorAsset:Class;
		
		[Embed(source="../../../../../../lib/assets/collectionCardTexture.png")]
		private var CardAsset:Class;
		
		[Embed(source="../../../../../../lib/assets/collectionCardSpellMirrorTexture.png")]
		private var MirrorSpellAsset:Class;
		
		[Embed(source="../../../../../../lib/assets/collectionCardSpellTexture.png")]
		private var CardSpellAsset:Class;
		
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
		
		private var mirrorContainer:Sprite;
		private var _mirror:Sprite;
		
		private var count:int;
		private var blockQuad:Quad;
		
		private var blockFlag:Boolean;
		
		public function CollectionCard(cardData:CollectionCardData) 
		{
			super();
			
			this.cardData = cardData;
            price = cardData.price;
            defaultPrice = price;
			
			formatCard();
            formatMirror();
			
			addEventListener(TouchEvent.TOUCH, onTouch);
			this.useHandCursor = true;
		}
		
		private function formatCard () :void {
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
			
			mirrorContainer.x -= MIRROR_WIDTH / 2;
			mirrorContainer.y -= MIRROR_HEIGHT / 2;
			_mirror.addChild(mirrorContainer)
			//container.
			var asset:Bitmap 
			if (cardData.type == CardData.UNIT) {  
				asset = new MirrorAsset();
			} else {
				asset = new MirrorSpellAsset();
			}
			var texture:Texture = Texture.fromBitmap(asset);
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
		
		public function get mirror () :Sprite {
			return _mirror;
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