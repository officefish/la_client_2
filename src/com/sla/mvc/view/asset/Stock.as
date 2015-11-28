package com.sla.mvc.view.asset 
{
	import com.transform.Transform;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Stock 
	{
		
		[Embed(source = "../../../../../../lib/assets/cards/default.png")]
		private static var DefaultAsset:Class;
	
		
		private static var AssetsTexture:Dictionary = new Dictionary();
		private static var MirrorAssetsTexture:Dictionary = new Dictionary();
		private static var MinionAssetsTexture:Dictionary = new Dictionary();
		
		private static function getBitmap (id:int) :Bitmap {
			var bitmap:Bitmap;
			if (id == 10) {
				bitmap = new Bitmap();
			}
			return bitmap;
		}
		
		private static var _defaultTexture:Texture;
		private static var _defaultMirrorTexture:Texture;
		private static var _defaultMinionTexture:Texture;
		private static function get defaultTexture () :Texture {
			if (!_defaultTexture) {
				var bitmap:Bitmap = new DefaultAsset();
				bitmap = Transform.scale(bitmap, 0.65);
				_defaultTexture	= Texture.fromBitmap(bitmap); 
			}
			return _defaultTexture;
		}
		private static function get defaultMinionTexture () :Texture {
			if (!_defaultMinionTexture) {
				var bitmap:Bitmap = new DefaultAsset();
				bitmap = Transform.scale(bitmap, 0.77);
				_defaultMinionTexture	= Texture.fromBitmap(bitmap); 
			}
			return _defaultMinionTexture;
		}
		private static function get defaultMirrorTexture () :Texture {
			if (!_defaultMirrorTexture) {
				var bitmap:Bitmap = new DefaultAsset();
				_defaultMirrorTexture	= Texture.fromBitmap(bitmap); 
			}
			return _defaultMirrorTexture;
		}
		
		
		public static function getTexture(id:int) :Texture {
			if (AssetsTexture[id]) {
				return AssetsTexture[id]
			} else {
				var bitmap:Bitmap = getBitmap(id);
				if (bitmap) {
					MirrorAssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = Transform.scale(bitmap, 0.65);
					AssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = getBitmap(id);
					bitmap = Transform.scale(bitmap, 0.77);
					MinionAssetsTexture[id] = Texture.fromBitmap(bitmap);
					return AssetsTexture[id];
				}
				return defaultTexture;	
			}
			
			
		}
		
		public static function getMirrorTextrure(id:int) :Texture {
			if (MirrorAssetsTexture[id]) {
				return MirrorAssetsTexture[id]
			} else {
				var bitmap:Bitmap = getBitmap(id);
				if (bitmap) {
					MirrorAssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = Transform.scale(bitmap, 0.65);
					AssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = getBitmap(id);
					bitmap = Transform.scale(bitmap, 0.77);
					MinionAssetsTexture[id] = Texture.fromBitmap(bitmap);
					return MirrorAssetsTexture[id];
				}
				return defaultMirrorTexture;	
			}
		}
		
		public static function getMinionTextrure(id:int) :Texture {
			if (MinionAssetsTexture[id]) {
				return MinionAssetsTexture[id]
			} else {
				var bitmap:Bitmap = getBitmap(id);
				if (bitmap) {
					MirrorAssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = Transform.scale(bitmap, 0.65);
					AssetsTexture[id] = Texture.fromBitmap(bitmap);
					bitmap = getBitmap(id);
					bitmap = Transform.scale(bitmap, 0.77);
					MinionAssetsTexture[id] = Texture.fromBitmap(bitmap);
					return MinionAssetsTexture[id];
				}
				return defaultMinionTexture;	
			}
		}
		
 		
	}

}