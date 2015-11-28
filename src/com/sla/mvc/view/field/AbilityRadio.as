package com.sla.mvc.view.field 
{
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityRadio extends Sprite 
	{
		
		[Embed(source="../../../../../../lib/assets/enableAbility.png")]
		public static var EnableAsset:Class;
		
		[Embed(source="../../../../../../lib/assets/abilityRadio.png")]
		public static var DisableAsset:Class;
		
		public static var _enableAssetTextute:Texture;
		public static function get EnableAssetTexture () :Texture {
			if (!_enableAssetTextute) { 
				_enableAssetTextute = Texture.fromBitmap(new EnableAsset());
			}
			return _enableAssetTextute;
		}
		
		public static var _disableAssetTextute:Texture;
		public static function get DisableAssetTexture () :Texture {
			if (!_disableAssetTextute) { 
				_disableAssetTextute = Texture.fromBitmap(new DisableAsset());
			}
			return _disableAssetTextute;
		}
		
		private var disableImage:Image;
		private var enableImage:Image;
		
		public function AbilityRadio() 
		{
			enableImage = new Image(EnableAssetTexture);
			enableImage.x = enableImage.y = -3;
			
			disableImage = new Image(DisableAssetTexture);
			disableImage.x = disableImage.y = -3;
			addChild(disableImage);
			
		}
		
		public function enable () : void {
			removeChildren();
			addChild(enableImage);
		}
		
		public function disable () :void {
			removeChildren();
			addChild(disableImage);
		}
		
	}

}