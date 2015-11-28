package com.sla.mvc.view.field 
{
	import com.sla.mvc.model.data.AbilityData;
	import flash.geom.Point;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class AbilitiesWidget extends Sprite 
	{
		
		private var abilities:Array;
		private var playerFlag:Boolean;
		
		private static var positions:Array = [
			new Point(240, 50),
			new Point(150, 50),
			new Point(60,50)
		]
		
		public function AbilitiesWidget(playerFlag:Boolean) 
		{
			this.playerFlag = playerFlag;
		}
		
		public function initAbilities (list:Vector.<AbilityData>) :void {
			this.removeChildren();
			abilities = [];
			var position:Point;
			var data:AbilityData;
			for (var i:int = 0; i < 3; i ++) {
				var ability:FieldEmptyAbilitySlot = new FieldEmptyAbilitySlot;
				position = positions[i];
				ability.x = position.x;
				ability.y = position.y;
				addChild(ability);
				abilities.push(ability);
			}
			
			for (i = 0; i < list.length; i ++) {
				data = list[i];
				var slot:FieldAbilitySlot = new FieldAbilitySlot(data, playerFlag);
				var emptySlot:FieldEmptyAbilitySlot = abilities[data.position];
				emptySlot.addAbility(slot);
			}
		}
		
		public function clear () :void {
			this.removeChildren();
		}
		
		public function getSlot (position:int) :FieldAbilitySlot {
			var emptySlot:FieldEmptyAbilitySlot = abilities[position];
			var slot:FieldAbilitySlot = emptySlot.getAbility();
			return slot;
		}
		
		
		
	}

}