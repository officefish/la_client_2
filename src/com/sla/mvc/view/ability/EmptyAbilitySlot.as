package com.sla.mvc.view.ability 
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class EmptyAbilitySlot extends Sprite 
	{
		
		[Embed(source="../../../../../../lib/assets/emptyAbility.png")]
		public static var Asset:Class;
		
		public static var _assetTextute:Texture;
		public static function get AssetTexture () :Texture {
			if (!_assetTextute) {
				_assetTextute = Texture.fromBitmap(new Asset());
			}
			return _assetTextute;
		}
		
		private var id:int;
		private var container:Sprite;
		private var slot:AbilitySlot;
		private var abilityId:int;
		private var abilityFlag:Boolean = false;
		
		
		public function EmptyAbilitySlot(id:int) 
		{
			container = new Sprite ();
			addChild(container);
			container.x = container.y = -35;
			
			var image:Image = new Image(EmptyAbilitySlot.AssetTexture);
			container.addChild(image);
			
			this.id = id;
		}
		
		public function getId():int {
			return id;
		}
		
		public function addAbility (slot:AbilitySlot) :void {
			abilityFlag = true;
			this.slot = slot;
			addChild(slot);
			this.abilityId = slot.abilityId;
		}
		
		public function getAbilityId() :int {
			return abilityId;
		}
		
		public function get hasAbility () :Boolean {
			return abilityFlag;
		}
		
		public function removeAbility () :void {
			abilityFlag = false;
			this.abilityId = -1;
			if (contains(slot)) {
				removeChild(slot);
			}
			slot = null;
		}
		
	}

}