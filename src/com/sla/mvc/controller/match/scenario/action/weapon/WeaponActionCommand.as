package com.sla.mvc.controller.match.scenario.action.weapon 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.weapon.Weapon;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class WeaponActionCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var field:Field;
				
		public function getWeapon (index:int, attachment:int, client:Boolean) :Weapon {
			var weapon:Weapon;
			if (client) {
				if (attachment) {
					weapon = field.getOpponentWeapon(index);
				} else {
					weapon = field.getPlayerWeapon(index);
				}
			} else {
				if (attachment) {
					weapon = field.getPlayerWeapon(index);
				} else {
					weapon = field.getOpponentWeapon(index);
				}
			}
			
			return weapon;
		}
		
	}

}