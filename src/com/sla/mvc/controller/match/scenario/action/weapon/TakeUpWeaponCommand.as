package com.sla.mvc.controller.match.scenario.action.weapon 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.ScenarioEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.weapon.Weapon;
	import flash.events.Event;
	import org.robotlegs.mvcs.StarlingCommand;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class TakeUpWeaponCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ScenarioEvent;
		
		[Inject]
		public var field:Field;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('TakeUpWeaponCommand::execute()');
			var client:Boolean = event.data.client;
			var playerWeaponIndex:int = event.data.playerWeaponIndex;
			var opponentWeaponIndex:int = event.data.opponentWeaponIndex;
			
			var weapon:Weapon = new Weapon(event.data.weaponId, event.data.power, event.data.strength);
			
			if (playerWeaponIndex) {
				if (client) {
					field.addWeapon(weapon, playerWeaponIndex, true);
				} else {
					field.addWeapon(weapon, playerWeaponIndex, false);
				}
			}
			
			if (opponentWeaponIndex) {
				if (client) {
					field.addWeapon(weapon, opponentWeaponIndex, false);
				} else {
					field.addWeapon(weapon, opponentWeaponIndex, true);
				}
			}
			
			dispatch(new ScenarioEvent(ScenarioEvent.ACTION));
		}
		
	}

}