package com.sla.mvc.view.ability 
{
	import com.sla.mvc.model.data.AbilityData;
	import feathers.controls.Label;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilitySlot extends Sprite 
	{
		
		[Embed(source="../../../../../../lib/assets/ability.png")]
		public static var Asset:Class;
		
		private var container:Sprite;
		
		private var label:Label;
		private var typeLabel:Label;
		
		private var data:AbilityData;
		
		public static var _assetTextute:Texture;
		public static function get AssetTexture () :Texture {
			if (!_assetTextute) { 
				_assetTextute = Texture.fromBitmap(new Asset());
			}
			return _assetTextute;
		}
		
		public function AbilitySlot(data:AbilityData) 
		{
			this.data = data;
			
			container = new Sprite ();
			addChild(container);
			container.x = container.y = -35;
			
			var image:Image = new Image(AbilitySlot.AssetTexture);
			container.addChild(image);
			
			this.useHandCursor = true;
			
			label = new Label();
			label.styleNameList.add('abilityLabel');
			label.text = data.title;
			label.width = 70;
			label.y = 30;
			container.addChild(label);
			
			typeLabel = new Label();
			typeLabel.styleNameList.add('abilityLabel');
			if (data.autonomic) {
				typeLabel.text = 'автономная';
			} else {
				typeLabel.text = 'общая';
			}
			typeLabel.width = 70;
			typeLabel.y = 45;
			container.addChild(typeLabel);
		}
		
		public function get abilityId():int {
			return data.id;
		} 
		
	}

}