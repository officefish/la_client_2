package com.sla.mvc.view.field.damage 
{
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Damage extends Sprite 
	{
		[Embed(source="../../../../../../../lib/assets/bang.png")]
		private static var Bang:Class;
		
		private var label:TextField 

		
		public function Damage(value:int) 
		{
			this.touchable = false;
			
			var image:Image = new Image(Damage.getBangTexture());
			image.x -= image.width / 2;
			image.y -= image.height / 2;
			addChild(image);
			
			label = new TextField(40, 40, value.toString(), 'Verdana', 24, 0x0, true);
			label.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS; 
			label.hAlign = HAlign.CENTER;
			label.x -= 12;
			label.y -= 24;
			addChild(label);
		}
		
		private static var _texture:Texture;
		private static function getBangTexture () :Texture {
			if (!_texture) {
				var bangAsset:Bitmap = new Bang();
				_texture = Texture.fromBitmap(bangAsset);
			}
			return _texture;
		}
		
	}

}