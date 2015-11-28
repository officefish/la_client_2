package com.sla.mvc.view.ability 
{
	import com.sla.mvc.model.data.AbilityData;
	import com.sla.mvc.view.card.CardFormater;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityCraftCard extends Sprite 
	{
		private var data:AbilityData;
		
		public static const CARD_WIDTH:int = 136;
		public static const CARD_HEIGHT:int = 190;
		
		private var priceLabel:Label; 
		private var attackLabel:Label; 
		private var healthLabel:Label;
		private var titleLabel:Label;
		private var descriptionArea:TextArea; 
		private var typeLabel:Label;
		private var countLabel:Label;
		
		private var craftPriceLabel:Label;
		private var craftTitleLabel:Label;
		private var craftDescriptionArea:TextArea; 
		private var craftTypeLabel:Label;
		
		private var mirrorPriceLabel:Label;
		private var mirrorTitleLabel:Label;
		private var mirrorDescriptionArea:TextArea; 
		private var mirrorTypeLabel:Label;
		
		private var craftMirrorPriceLabel:Label;
		private var craftMirrorTitleLabel:Label;
		private var craftMirrorDescriptionArea:TextArea; 
		private var craftMirrorTypeLabel:Label;
		
		
		private var cardContainer:Sprite;
		private var craftContainer:Sprite;
		private var blockQuad:Quad;
		
		private var state:int;
		
		private var mirror:Sprite;
		private var craftMirror:Sprite;
		
		private var mirrorContainer:Sprite;
		private var craftMirrorContainer:Sprite;
		
		public static const DEFAULT_STATE:int = 0;
		public static const CRAFT_STATE:int = 1;
		
		public static const MIRROR_WIDTH:int = 250;
		public static const MIRROR_HEIGHT:int = 350;
		
		[Embed(source="../../../../../../lib/assets/collectionCardSpellTexture.png")]
		private static var CardAsset:Class;
		private static var _cardTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCraftCardSpellTexture.png")]
		private static var CraftCardAsset:Class;
		private static var _craftCardTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCardSpellMirrorTexture.png")]
		private static var MirrorAsset:Class;
		private static var _mirrorTexture:Texture;
		
		[Embed(source="../../../../../../lib/assets/collectionCraftCardSpellMirrorTexture.png")]
		private static var CraftMirrorAsset:Class;
		private static var _craftMirrorTexture:Texture;
		
		
		private static function get mirrorTexture () :Texture {
			if (!_mirrorTexture) {
				_mirrorTexture = Texture.fromBitmap(new MirrorAsset());
			}
			return _mirrorTexture;
		}
		
		private static function get craftMirrorTexture () :Texture {
			if (!_craftMirrorTexture) {
				_craftMirrorTexture = Texture.fromBitmap(new CraftMirrorAsset());
			}
			return _craftMirrorTexture;
		}
		
		private static function get cardTexture () :Texture {
			if (!_cardTexture) {
				_cardTexture = Texture.fromBitmap(new CardAsset());
			}
			return _cardTexture;
		}
		
		private static function get craftCardTexture () :Texture {
			if (!_craftCardTexture) {
				_craftCardTexture = Texture.fromBitmap(new CraftCardAsset);
			}
			return _craftCardTexture;
		}
		
		public function AbilityCraftCard(data:AbilityData) 
		{
			this.data = data;
			formatCard();
			formatCraftCard();
			formatMirror();
			formatCraftMirror();
			
			if (data.count) {
				this.state = DEFAULT_STATE;
				addChild(cardContainer);
			} else {
				this.state = CRAFT_STATE;
				addChild(craftContainer);
			}
		}
		
		public function getData () :AbilityData {
			return this.data;
		}
		
		private function formatCard () :void {
			cardContainer = new Sprite;
			addChild(cardContainer);
			cardContainer.x -= CARD_WIDTH / 2;
			cardContainer.y -= CARD_HEIGHT / 2;

			var texture:Texture = AbilityCraftCard.cardTexture;
			var body:Image = new Image(texture);  
			cardContainer.addChild(body);
			
			priceLabel = CardFormater.drawCollectionValueLabel(data.price.toString()); 
			priceLabel.width = 28;
			priceLabel.height = 28;
			priceLabel.x += 2;
			priceLabel.y += 2;
			cardContainer.addChild(priceLabel);
			
			titleLabel = CardFormater.drawCollectionTitleLabel(data.title);
			titleLabel.width = CARD_WIDTH - 6;
			titleLabel.x = 0;
			titleLabel.y = Math.round (this.height * 0.45);
			cardContainer.addChild (titleLabel);
			
			descriptionArea = CardFormater.drawCollectionDescriptionArea(data.description);
			descriptionArea.width = CARD_WIDTH - 20;
			descriptionArea.x = 10;
			descriptionArea.height = 50;
			descriptionArea.y = Math.round (this.height * 0.55);
            cardContainer.addChild (descriptionArea);
			
			typeLabel = CardFormater.drawCollectionTypeLabel ();
			typeLabel.y = Math.round (this.height * 0.88);
			typeLabel.width = CARD_WIDTH;
			cardContainer.addChild (typeLabel);
			
			if (data.autonomic) {
				typeLabel.text = 'автономная';
			} else {
				typeLabel.text = 'общая';
			}
			
			countLabel = CardFormater.drawCollectionCountLabel(20);
			countLabel.y = CARD_HEIGHT;
			countLabel.x = (CARD_WIDTH - countLabel.width) / 2;
			if (data.count > 1) {
				countLabel.text = 'x' + data.count;
			}
			cardContainer.addChild(countLabel);
			
			blockQuad = new Quad(CARD_WIDTH, CARD_HEIGHT, 0x222222); 
			blockQuad.alpha = 0.5;
			
			this.useHandCursor = true;
			
		}
		
		private function formatCraftCard () :void {
			craftContainer = new Sprite;
			addChild(craftContainer);
			craftContainer.x -= CARD_WIDTH / 2;
			craftContainer.y -= CARD_HEIGHT / 2;

			var texture:Texture = AbilityCraftCard.craftCardTexture;
			var body:Image = new Image(texture);  
			craftContainer.addChild(body);
			
			craftPriceLabel = CardFormater.drawCraftCollectionValueLabel(data.price.toString());
			craftPriceLabel.width = 28;
			craftPriceLabel.height = 28;
			craftPriceLabel.x += 2;
			craftPriceLabel.y += 2;
			craftContainer.addChild(craftPriceLabel);
			
			craftTitleLabel = CardFormater.drawCraftCollectionTitleLabel(data.title);
			craftTitleLabel.width = CARD_WIDTH - 6;
			craftTitleLabel.x = 0;
			craftTitleLabel.y = Math.round (this.height * 0.45);
			craftContainer.addChild (craftTitleLabel);
			
			craftDescriptionArea = CardFormater.drawCraftCollectionDescriptionArea(data.description);
			craftDescriptionArea.width = CARD_WIDTH - 20;
			craftDescriptionArea.x = 10;
			craftDescriptionArea.height = 50;
			craftDescriptionArea.y = Math.round (this.height * 0.55);
            craftContainer.addChild (craftDescriptionArea);
			
			craftTypeLabel = CardFormater.drawCraftCollectionTypeLabel ();
			craftTypeLabel.y = Math.round (this.height * 0.88);
			craftTypeLabel.width = CARD_WIDTH;
			craftContainer.addChild (craftTypeLabel);
			
			if (data.autonomic) {
				craftTypeLabel.text = 'автономная';
			} else {
				craftTypeLabel.text = 'общая';
			}
		}
		
		private function formatMirror () :void {
			mirror = new Sprite;
			
			mirrorContainer = new Sprite();
			mirrorContainer.x -= MIRROR_WIDTH / 2;
			mirrorContainer.y -= MIRROR_HEIGHT / 2;
			
			mirror.addChild(mirrorContainer);

			var texture:Texture = AbilityCraftCard.mirrorTexture;
			var body:Image = new Image(texture);  
			mirrorContainer.addChild(body);
			
			mirrorPriceLabel = CardFormater.drawCollectionMirrorValueLabel(data.price.toString());
			mirrorPriceLabel.width = 50;
			mirrorPriceLabel.height = 50;
			mirrorPriceLabel.x += 4;
			mirrorPriceLabel.y += 6;
			mirrorContainer.addChild(mirrorPriceLabel);
			
			mirrorTitleLabel = CardFormater.drawCollectionMirrorTitleLabel(data.title);
			mirrorTitleLabel.width = MIRROR_WIDTH - 20;
			mirrorTitleLabel.x = 10;
			mirrorTitleLabel.y = Math.round (MIRROR_HEIGHT * 0.45);
			mirrorContainer.addChild (mirrorTitleLabel);
			
			mirrorDescriptionArea = CardFormater.drawCollectionMirrorDescriptionArea(data.description);
			mirrorDescriptionArea.width = MIRROR_WIDTH - 50;
			mirrorDescriptionArea.x = 25;
			mirrorDescriptionArea.height = 90;
			mirrorDescriptionArea.y = Math.round (MIRROR_HEIGHT * 0.57);
            mirrorContainer.addChild (mirrorDescriptionArea);
			
			mirrorTypeLabel = CardFormater.drawCollectionMirrorTypeLabel ();
			mirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.90);
			mirrorTypeLabel.width = MIRROR_WIDTH;
			mirrorContainer.addChild (mirrorTypeLabel);
			
			if (data.autonomic) {
				mirrorTypeLabel.text = 'автономная';
			} else {
				mirrorTypeLabel.text = 'общая';
			}
		}
		
		private function formatCraftMirror () :void {
			craftMirror = new Sprite();
			
			craftMirrorContainer = new Sprite();
			craftMirrorContainer.x -= MIRROR_WIDTH / 2;
			craftMirrorContainer.y -= MIRROR_HEIGHT / 2;
			
			craftMirror.addChild(craftMirrorContainer);

			var texture:Texture = AbilityCraftCard.craftMirrorTexture;
			var body:Image = new Image(texture);  
			craftMirrorContainer.addChild(body);
			
			craftMirrorPriceLabel = CardFormater.drawCraftCollectionMirrorValueLabel(data.price.toString());
			craftMirrorPriceLabel.width = 50;
			craftMirrorPriceLabel.height = 50;
			craftMirrorPriceLabel.x += 4;
			craftMirrorPriceLabel.y += 6;
			craftMirrorContainer.addChild(craftMirrorPriceLabel);
			
			craftMirrorTitleLabel = CardFormater.drawCraftCollectionMirrorTitleLabel(data.title);
			craftMirrorTitleLabel.width = MIRROR_WIDTH - 20;
			craftMirrorTitleLabel.x = 10;
			craftMirrorTitleLabel.y = Math.round (MIRROR_HEIGHT * 0.45);
			craftMirrorContainer.addChild (craftMirrorTitleLabel);
			
			craftMirrorDescriptionArea = CardFormater.drawCraftCollectionMirrorDescriptionArea(data.description);
			craftMirrorDescriptionArea.width = MIRROR_WIDTH - 50;
			craftMirrorDescriptionArea.x = 25;
			craftMirrorDescriptionArea.height = 90;
			craftMirrorDescriptionArea.y = Math.round (MIRROR_HEIGHT * 0.57);
            craftMirrorContainer.addChild (craftMirrorDescriptionArea);
			
			craftMirrorTypeLabel = CardFormater.drawCraftCollectionMirrorTypeLabel ();
			craftMirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.90);
			craftMirrorTypeLabel.width = MIRROR_WIDTH;
			craftMirrorContainer.addChild (craftMirrorTypeLabel);
			
			if (data.autonomic) {
				craftMirrorTypeLabel.text = 'автономная';
			} else {
				craftMirrorTypeLabel.text = 'общая';
			}
		}
		
		public function getPreview () :Sprite {
			var preview:Sprite;
			if (state == DEFAULT_STATE) {
				preview = mirror;
			} else {
				preview = craftMirror;
			}
			return preview;
		}
		
		public function setState (state:int) :void {
			this.state = state;
			this.removeChildren();
			if (data.count) {
				addChild(cardContainer);
			} else {
				addChild(craftContainer);
			}
			
		}
		
		public function getState () :int {
			return state;
		}
		
		
		
	}

}