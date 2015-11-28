package com.sla.mvc.view.field 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class FieldEmptyAbilitySlot extends Sprite 
	{
		
		[Embed(source="../../../../../../lib/assets/emptyFieldAbility.png")]
		public static var Asset:Class; 
		
		public static var _assetTextute:Texture;
		public static function get AssetTexture () :Texture {
			if (!_assetTextute) {
				_assetTextute = Texture.fromBitmap(new Asset());
			}
			return _assetTextute;
		}
		
		private var container:Sprite;
		private var ability:FieldAbilitySlot;
		
		public function FieldEmptyAbilitySlot() 
		{
			container = new Sprite ();
			addChild(container);
			container.x = container.y = -35;
			
			var image:Image = new Image(FieldEmptyAbilitySlot.AssetTexture); 
			container.addChild(image);			
		}
		
		public function addAbility (ability:Sprite) :void {
			this.ability = ability as FieldAbilitySlot;
			addChild(ability);
		}
		
		public function getAbility () :FieldAbilitySlot {
			return ability;
		}
		
	}

}