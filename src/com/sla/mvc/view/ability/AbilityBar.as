package com.sla.mvc.view.ability 
{
	import com.sla.theme.Assets;
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilityBar extends Sprite 
	{
		private var container:Sprite;
		private var slots:Vector.<EmptyAbilitySlot>;
		
		private var heroAssetX:int = 500;
		
		private var positions:Array = 
		[
			new Point(340, 55), 
			new Point(220, 55),
			new Point(100, 55), 
		]
		
		public function AbilityBar() 
		{
			var quad:Quad = new Quad(620, 120, 0x777777);
			quad.alpha = 0.1;
			addChild(quad);
			
			container = new Sprite();
			addChild(container);
		}
		
		public function initHero(vocation:int):void {
			
			container.removeChildren();
			
			slots = new Vector.<EmptyAbilitySlot>();
			
			var texture:Texture = Assets.getHeroAssetById(vocation);
			var asset:Image = new Image(texture);
			addChild(asset); 
			
			asset.x = heroAssetX;
			asset.y = (this.height - asset.height) / 2;
			
			
			for (var i:int = 0; i < 3; i ++) {
				var slot:EmptyAbilitySlot = new EmptyAbilitySlot(i);
				container.addChild(slot);
				var position:Point = positions[i];
				slot.x = position.x;
				slot.y = position.y;
				slots.push(slot);
			}
		}
		
		
		
		public function addSlot (slot:AbilitySlot, position:int) :void {
			var eSlot:EmptyAbilitySlot = getSlotById(position);
			if (eSlot) {
				eSlot.addAbility(slot); 
			}
			
		}
		
		private function getSlotById (id:int) :EmptyAbilitySlot {
			return slots[id];
		}
		
		public function removeAbility (abilityId:int) :void {
			for (var i:int = 0; i < slots.length; i ++) {
				var eSlot:EmptyAbilitySlot = slots[i];
				if (eSlot.getAbilityId() == abilityId) {
					eSlot.removeAbility();
				}
			}
		}
		
		public function addNewSlot (slot:AbilitySlot) :Boolean {
			var flag:Boolean = false;
			for (var i:int = 0; i < slots.length; i ++) {
				var eSlot:EmptyAbilitySlot = slots[i];
				if (eSlot.hasAbility) {
					continue;
				} else {
					flag = true;
					eSlot.addAbility(slot); 
					break;
				}
			}
			return flag;
		}
		
		public function getSetupData() :Array {
			var data:Array = [] 
			var slot:EmptyAbilitySlot
			for (var i:int = 0; i < slots.length; i ++ ) {
				slot = slots[i] as EmptyAbilitySlot;
				if (slot.hasAbility) {
					var slotData:Object = { }
					slotData.position = slot.getId();
					slotData.achieve = slot.getAbilityId();
					data.push(slotData)
				}
			}
			return data;
		}
		
		
	}

}