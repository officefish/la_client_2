package com.sla.mvc.view.collection.deck 
{
	import com.transform.Transform;
	import feathers.controls.TextInput;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import com.sla.mvc.model.data.HeroData;
	import com.sla.theme.Assets;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroTitle extends Sprite
	{
		
		private var input:TextInput;
		private var shirme:Quad;
		
		public function HeroTitle() 
		{
			var quad:Quad = new Quad(180, 50, 0x222222);
			addChild(quad); 
			
			shirme = new Quad(180, 50, 0x222222);
			shirme.alpha = 0.7;
			
			input = new TextInput();
			input.setFocus();
			input.y = 30;
			input.x = 7;
			input.width = 170;
			input.isEditable = true;
			input.maxChars = 20;
			input.styleNameList.add('decklistHeroTitleInput');
			addChild(input);
			
		}
		
		public function set text (value:String) :void {
			input.text = value;
		}
		
		public function setHero (data:HeroData, count:int = 0) :void {
			this.removeChildren();
			var asset:Bitmap = Assets.getHeroAssetBitmapById(data.uid);  
			asset = Transform.scale (asset, 180 / asset.width);
			asset = Transform.cropAndShift (asset, new Rectangle (0,0, 180, 50), 0,0);
			var texture:Texture = Texture.fromBitmap(asset);
			var image:Image = new Image(texture); 
			addChild(image); 
			addChild(shirme);
			addChild (input);
		}
		
	}

}