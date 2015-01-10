package com.la.mvc.view.collection 
{
	import com.la.assets.Assets;
	import com.la.mvc.model.HeroData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroSlot extends Sprite 
	{
		
		private var vocationLabel:TextField;
		private var titleLabel:TextField;
		
		private var titleBlock:Sprite;
		
		private var titleFormat:TextFormat;
		private var vocationFormat:TextFormat;
		
		private var data:HeroData;
		
		
		public function HeroSlot(data:HeroData) 
		{
			buttonMode = true;
			this.data = data;
			
			var asset:Bitmap = Assets.getHeroAssetById(data.uid);
			addChild(asset); 
			
			titleBlock = new Sprite ();
			titleBlock.graphics.beginFill (0xFFFFFF, 1);
			titleBlock.graphics.drawRect (0, 0, 120, 50);
			titleBlock.graphics.endFill();
			addChild(titleBlock);
			titleBlock.y = 110;
			
			titleFormat = new TextFormat ();
			titleFormat.align = TextFormatAlign.CENTER;
			titleFormat.bold = true;
			titleFormat.size = 14;
			
			titleLabel = new TextField ();
			titleLabel.defaultTextFormat = titleFormat;
			titleLabel.width = 120;
			titleLabel.height = 20;
			titleLabel.text = data.title;
			titleLabel.y = 5;
			titleLabel.mouseEnabled = false;
			titleBlock.addChild(titleLabel);
			
			vocationFormat = new TextFormat ();
			vocationFormat.align = TextFormatAlign.CENTER;
			vocationFormat.size = 13;
			
			vocationLabel = new TextField();
			vocationLabel.defaultTextFormat = vocationFormat;
			vocationLabel.text = data.vocation;
			vocationLabel.width = 120;
			vocationLabel.height = 20;
			vocationLabel.y = 25;
			vocationLabel.mouseEnabled = false;
			titleBlock.addChild (vocationLabel);
		}
		
		public function glow () :void {
			this.filters = [new GlowFilter(0x56A5EC)]
		}
		
		public function stopGlow() :void {
			this.filters = null;		
		}
		
		public function getData () :HeroData {
			return data;
		}
		
	}

}