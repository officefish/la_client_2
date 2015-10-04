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
		
	[Embed(source="../../../../lib/assets/nivanh-chanthara-babiru-kid-04c.png")]
	private static var HunterAsset:Class;
    [Embed(source="../../../../lib/assets/nivanh-chanthara-test-126.png")]
	private static var AdventurerAsset:Class;
    [Embed(source="../../../../lib/assets/justin-spice-her.png")]
	private static var MonkAsset:Class;

	private static const ADVENTURER:int = 0;
	private static const HUNTER:int = 1;
	private static const MONK:int = 2;
	
	private static var _hunterBitmap:Bitmap;
	private static var _adventurerBitmpap:Bitmap;
	private static var _monkBitmap:Bitmap; 
	
	private static var _hunterTexture:Texture;
	private static var _adventurerTexture:Texture;
	private static var _monkTexture:Texture; 

  

    public static function getHunter () :Texture {
        if (!_hunterBitmap) {
			_hunterBitmap = new HunterAsset as Bitmap; 
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

    public static function getMonk () :Texture {
        if (!_monkBitmap) {
			_monkBitmap = new MonkAsset as Bitmap; 
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
            case HUNTER: {
                asset = getHunter();
                break;
            }
            case MONK: {
                asset = getMonk();
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
            case HUNTER: {
                asset = new HunterAsset as Bitmap;
                break;
            }
            case MONK: {
                asset = new MonkAsset as Bitmap;
                break;
            }
        }
        return asset;
    }
		
	}
	
	

}