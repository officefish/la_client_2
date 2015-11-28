package com.sla.theme 
{
	import flash.display.Bitmap;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Assets 
	{
		
	[Embed(source="../../../../lib/assets/justin-spice-her.png")]
	private static var ShamanAsset:Class;
    [Embed(source="../../../../lib/assets/nivanh-chanthara-babiru-kid-04c.png")]
	private static var AdventurerAsset:Class;
	[Embed(source="../../../../lib/assets/nivanh-chanthara-test-126.png")]
  	private static var RaingerAsset:Class;

	private static const ADVENTURER:int = 0;
	private static const SHAMAN:int = 1;
	private static const RAINGER:int = 2;
	
	private static var _hunterBitmap:Bitmap;
	private static var _adventurerBitmpap:Bitmap;
	private static var _monkBitmap:Bitmap; 
	
	private static var _hunterTexture:Texture;
	private static var _adventurerTexture:Texture;
	private static var _monkTexture:Texture; 

  

    public static function getShaman () :Texture {
        if (!_hunterBitmap) {
			_hunterBitmap = new ShamanAsset as Bitmap; 
		}
		if (!_hunterTexture) {
			_hunterTexture = Texture.fromBitmap(_hunterBitmap);
		}
		
		return _hunterTexture;
	}

    public static function getAdventurer () :Texture {
        if (!_adventurerBitmpap) {
			_adventurerBitmpap = new AdventurerAsset as Bitmap; 
		}
		if (!_adventurerTexture) {
			_adventurerTexture = Texture.fromBitmap(_adventurerBitmpap);
		}
		
		return _adventurerTexture;
	}

    public static function getRainger () :Texture {
        if (!_monkBitmap) {
			_monkBitmap = new RaingerAsset as Bitmap; 
		}
		if (!_monkTexture) {
			_monkTexture = Texture.fromBitmap(_monkBitmap);
		}
		return _monkTexture;
    }
		
		
	public static function getHeroAssetById (id:int) :Texture {
        var asset:Texture;
        switch (id) {
            case ADVENTURER: {
                asset = getAdventurer();
                break;
            }
            case SHAMAN: {
                asset = getShaman();
                break;
            }
            case RAINGER: {
                asset = getRainger();
                break;
            }
        }
        return asset;
    }
	
	public static function getHeroAssetBitmapById (id:int) :Bitmap {
        var asset:Bitmap;
        switch (id) {
            case ADVENTURER: {
                asset = new AdventurerAsset as Bitmap;
                break;
            }
            case SHAMAN: {
                asset = new ShamanAsset as Bitmap;
                break;
            }
            case RAINGER: {
                asset = new RaingerAsset as Bitmap;
                break;
            }
        }
        return asset;
    }
		
	}
	
	

}