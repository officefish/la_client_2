package com.la.mvc.view.collection 
{
	import com.la.assets.Assets;
	import com.la.mvc.model.HeroData;
	import com.transform.Transform;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroTitle extends Sprite 
	{
		
		private var label:TextField;
		
		public function HeroTitle() 
		{
			graphics.beginFill (0x999999);
			graphics.drawRect (0, 0, 180, 50);
			graphics.endFill ();
			
			var format:TextFormat = new TextFormat();
			format.align = TextFormatAlign.CENTER;
			format.color = 0xEEEEEE;
			format.size = 18;
			format.bold = true;
			
			label = new TextField ();
			label.defaultTextFormat = format;
			label.width = this.width;
			label.type = TextFieldType.INPUT;
			label.maxChars = 15;
			label.y = 24;
			label.height = 25;
			label.text = 'Мои колоды';
			addChild(label)
		}
		
		public function setHero (data:HeroData, count:int = 0) :void {
			var asset:Bitmap = Assets.getHeroAssetById(data.uid);
			asset = Transform.scale (asset, this.width / asset.width);
			asset = Transform.crop (asset, new Rectangle (0,0, 180, 50));
			addChild(asset); 
			addChild (label);
		}
		
		public function setTitle (value:String) :void {
			label.text = value;
		}
		
		public function getTitle () :String {
			return label.text;
		}
	}

}