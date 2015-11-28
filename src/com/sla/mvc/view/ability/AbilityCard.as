package com.sla.mvc.view.ability 
{
	import com.sla.mvc.model.data.AbilityData;
	import com.sla.mvc.view.card.CardFormater;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityCard extends Sprite 
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
		
		[Embed(source="../../../../../../lib/assets/collectionCardSpellTexture.png")]
		private static var CardAsset:Class;
		private static var _cardTexture:Texture;
		private var cardContainer:Sprite;
		
		private var blockFlag:Boolean = false;
		private var blockQuad:Quad;
		
		public function AbilityCard(data:AbilityData) 
		{
			this.data = data;
			formatCard();
		}
		
		public function getData() :AbilityData {
			return data;
		}
		
		private static function get cardTexture () :Texture {
			if (!_cardTexture) {
				_cardTexture = Texture.fromBitmap(new CardAsset());
			}
			return _cardTexture;
		}
		
		
		private function formatCard () :void {
			cardContainer = new Sprite;
			addChild(cardContainer);
			cardContainer.x -= CARD_WIDTH / 2;
			cardContainer.y -= CARD_HEIGHT / 2;

			var texture:Texture = AbilityCard.cardTexture;
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
		
		public function block() :void {
			blockFlag = true;
			cardContainer.addChild(blockQuad);
			this.useHandCursor = false;
		}
		
		public function unblock () :void {
			blockFlag = false;
			if (cardContainer.contains(blockQuad)) {
				cardContainer.removeChild(blockQuad);
			}
			this.useHandCursor = true;
		}
		
		public function get isBlocked () :Boolean {
			return blockFlag;
		}
		
		public function get abilityId () :int {
			return this.data.id;
		}
		
		
	}

}