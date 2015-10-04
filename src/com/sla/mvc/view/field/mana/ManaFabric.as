package com.sla.mvc.view.field.mana 
{
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ManaFabric 
	{
		
		[Embed(source = "../../../../../../../lib/assets/mana/miniMana.png")]
		private static var ManaAsset:Class;
		
		[Embed(source = "../../../../../../../lib/assets/mana/overloadMiniMana.png")]
		private static var OverloadAsset:Class;
		
		public function ManaFabric() 
		{
			
		}
		
		public static function getEmptyItem () :Sprite {
			var sprite:Sprite = new Sprite();
			var quad:Quad = new Quad(4, 4, 0x0f54be);
			quad.x = quad.y = - 2;
			sprite.addChild(quad)
			return sprite;
		}
		
		public static function getManaItem () :Sprite {
			var sprite:Sprite = new Sprite;
			var image:Image = new Image(manaTexture);
			sprite.addChild(image);
			image.x -= image.width / 2;
			image.y -= image.height / 2;
			return sprite;
		}
		
		private static var _manaTexture:Texture;
		private static function get manaTexture () :Texture {
			if (!_manaTexture) {
				var asset:Bitmap = new ManaAsset();
				_manaTexture = Texture.fromBitmap(asset);
			}
			return _manaTexture;
		}
		
		public static function getOveloadItem () :Sprite {
			var sprite:Sprite = new Sprite;
			var image:Image = new Image(overloadTexture);
			sprite.addChild(image);
			image.x -= image.width / 2;
			image.y -= image.height / 2;
			return sprite;
		}
		
		private static var _overloadTexture:Texture;
		private static function get overloadTexture () :Texture {
			if (!_overloadTexture) {
				var asset:Bitmap = new OverloadAsset();
				_overloadTexture= Texture.fromBitmap(asset);
			}
			return _overloadTexture;
		}
		
	}

}