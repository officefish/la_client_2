package com.sla.mvc.view.field 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.la.mvc.view.collection.NewDeckButton;
	import com.sla.mvc.model.data.AbilityData;
	import com.sla.mvc.view.card.CardFormater;
	import feathers.controls.Label;
	import feathers.controls.TextArea;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.filters.BlurFilter;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldAbilitySlot extends Sprite 
	{
		[Embed(source="../../../../../../lib/assets/ability.png")]
		public static var Asset:Class; 
		
		[Embed(source="../../../../../../lib/assets/cardMirrorSpellTexture.png")]
		private static var MirrorSpellAsset:Class;
		private static var _mirrorSpellTexture:Texture;
		
		private var label:Label;
		private var priceLabel:Label;
		private var data:AbilityData;
		
		private var container:Sprite;
		private var playerFlag:Boolean;
		
		private var enableFlag:Boolean = false;
		
		private var abilityMagaWidget:FieldAbilityManaWidget;
		
		private var image:Image;
		
		private var showMirroFlag:Boolean = false;
		
		private var mirrorContainer:Sprite;
		private var mirror:Sprite;
		
		public static const MIRROR_WIDTH:int = 154;
		public static const MIRROR_HEIGHT:int = 224;
		
		private var mirrorPriceLabel:Label;
		private var mirrorTitleLabel:Label;
		private var mirrorDescriptionArea:TextArea; 
		private var mirrorTypeLabel:Label;
		
		private var type:int;
		
		public static var _assetTextute:Texture;
		public static function get AssetTexture () :Texture {
			if (!_assetTextute) { 
				_assetTextute = Texture.fromBitmap(new Asset());
			}
			return _assetTextute;
		}
		
		private static var _mirrorTexture:Texture;
		private static function get mirrorTexture () :Texture {
			if (!_mirrorTexture) {
				_mirrorTexture = Texture.fromBitmap(new MirrorSpellAsset());
			}
			return _mirrorTexture;
		}
		
		
		public function FieldAbilitySlot(data:AbilityData, playerFlag:Boolean) 
		{
			this.data = data;
			this.playerFlag = playerFlag;
			this.type = data.type;
			
			container = new Sprite ();
			addChild(container);
			container.x = container.y = -35;
			
			image = new Image(FieldAbilitySlot.AssetTexture); 
			container.addChild(image);
			
			this.useHandCursor = true;
			
			label = new Label();
			label.styleNameList.add('abilityLabel');
			label.text = data.title;
			label.width = 70;
			label.y = 30;
			container.addChild(label);
			
			var priceQuad:Quad = new Quad(16, 16, 0xFFFFFF);
			priceQuad.x = 27;
			priceQuad.y = 53;
			container.addChild(priceQuad);
			
			priceLabel = new Label();
			priceLabel.styleNameList.add('abilityPriceLabel');
			priceLabel.text = data.price.toString();
			priceLabel.width = 20;
			priceLabel.y = 53;
			priceLabel.x = 25;
			container.addChild(priceLabel);
			
			if (data.autonomic) {
				abilityMagaWidget = new FieldAbilityManaWidget(data.price, playerFlag);
				abilityMagaWidget.x = -5;
				if (playerFlag) {
					abilityMagaWidget.y = - 7;
				} 
				
				container.addChild(abilityMagaWidget);
			}
			
			formatMirror();
			
		}
		
		private function formatMirror () :void {
			mirror = new Sprite();
			
			mirrorContainer = new Sprite();
			mirror.addChild(mirrorContainer);
			
			mirrorContainer.x -= MIRROR_WIDTH/2;
			mirrorContainer.y -= MIRROR_HEIGHT/2;
			var texture:Texture = FieldAbilitySlot.mirrorTexture;
			
			var body:Image = new Image(texture);
			mirrorContainer.addChild(body);
			
			mirrorPriceLabel = CardFormater.drawMirrorValueLabel(data.price.toString());
            mirrorPriceLabel.width = 31;
			mirrorPriceLabel.height = 31; 
			mirrorContainer.addChild (mirrorPriceLabel);
			
			mirrorTitleLabel = CardFormater.drawMirrorTitleLabel (data.title);
            mirrorTitleLabel.width = MIRROR_WIDTH - 10;
			mirrorTitleLabel.x = 5;
			mirrorTitleLabel.y = Math.round (mirror.height * 0.45);
			mirrorContainer.addChild (mirrorTitleLabel);

            mirrorDescriptionArea = CardFormater.drawMirrorDescriptionArea(data.description)
            mirrorDescriptionArea.width = MIRROR_WIDTH - 20;
			mirrorDescriptionArea.x = 10;
			mirrorDescriptionArea.height = 80;
			mirrorDescriptionArea.y = Math.round (mirror.height * 0.55);
            mirrorContainer.addChild (mirrorDescriptionArea);
						
			mirrorTypeLabel = CardFormater.drawMirrorTypeLabel ();
			mirrorTypeLabel.y = Math.round (MIRROR_HEIGHT * 0.9);
			mirrorTypeLabel.width = MIRROR_WIDTH;
			mirrorContainer.addChild (mirrorTypeLabel);
			
			if (data.autonomic) {
				mirrorTypeLabel.text = 'автономная';
			} else {
				mirrorTypeLabel.text = 'общая';
			}
			
			
		}
		
		public function getData() :AbilityData {
			return this.data;
		}
		
		public function getPosition() :int {
			return this.data.position;
		}
		
		public function getType() :int {
			return type;
		}
		
		public function getMirror () :Sprite {
			return mirror;
		}
	
		
		public function enable () :void {
			enableFlag = true;
			glow();
		}
		
		public function disable () :void {
			enableFlag = false;
			stopGlow();
			if (abilityMagaWidget) {
				abilityMagaWidget.disable();
			}
		}
		
		public function get isActive () :Boolean {
			return enableFlag;
		}
		
		public function glow () :void {
			image.filter = FieldAbilitySlot.glowFilter;
		}
		
		public function stopGlow () :void {
			image.filter = null;
		}
		private static var _glowWilter:BlurFilter; 
		private static function get glowFilter () :BlurFilter {
			if (!_glowWilter) {
				_glowWilter = BlurFilter.createGlow(0x00FFFF, 1, 3, .5);
			}
			return _glowWilter;
		}
		
		public function increment(price:int) :void {
			abilityMagaWidget.increment(price);
		}
		
		public function set showMirror (value:Boolean) :void {
			showMirroFlag = value;
		}
		
		public function get showMirror () :Boolean {
			return showMirroFlag;
		}
		
		public function get isEnemy () :Boolean {
			return !playerFlag;
		}
		
		
	}

}