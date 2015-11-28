package com.sla.mvc.controller.match.scenario.action.weapon 
{
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.weapon.Weapon;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class WeaponStrengthCommand extends WeaponActionCommand 
	{
		
		override public function execute():void 
		{
			var weapon:Weapon = getWeapon(event.data.weaponIndex, event.data.attachment, event.data.client);
			weapon.strength (event.data.strength);
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
	}

}