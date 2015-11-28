package com.sla.mvc.controller.match.scenario.action.weapon 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.weapon.Weapon;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class GlowWeaponCommand extends WeaponActionCommand 
	{
		
		override public function execute():void 
		{
			var weapon:Weapon = getWeapon(event.data.weaponIndex, event.data.attachment, event.data.client);
			weapon.glow();
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
			
		}
		
	}

}