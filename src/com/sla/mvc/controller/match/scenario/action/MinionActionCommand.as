package com.sla.mvc.controller.match.scenario.action 
{
	import com.sla.event.DataEvent;
	import com.sla.mvc.view.field.Field;
	import com.sla.mvc.view.field.minion.hero.IHero;
	import com.sla.mvc.view.field.minion.IMinion;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MinionActionCommand extends StarlingCommand 
	{
		[Inject]
		public var field:Field;
		
		[Inject (name = 'playerHero')]
		public var playerHero:IHero;

		[Inject (name = 'opponentHero')]
		public var opponentHero:IHero; 
		
		
		public function initMinionByAttachment (index:int, attachment:int, client:Boolean) :IMinion {
			var minion:IMinion;
			if (client) {
				if (index >= 0) {
					if (attachment) {
						minion = field.getMinion(index, true);
					} else {
						minion = field.getMinion(index, false);
					}
				} else {
					if (attachment == 1) {
						minion = playerHero;
					} else if (attachment == 0) {
						minion = opponentHero;
					}
				}
			} else {
				if (index >= 0) {
					if (attachment) {
						minion = field.getMinion(index, false);
					} else {
						minion = field.getMinion(index, true);
					}
				} else {
					if (attachment == 1) {
						minion = opponentHero;
					} else if (attachment == 0) {
						minion = playerHero;
					}
				}
			}
			return minion;
			
		}	
		
		
		public function getTarget (index:int, attachment:int, client:Boolean) :IMinion {
			var minion:IMinion = this.initMinionByAttachment(index, attachment, client);
			return minion;
		}
		
		public function getTargetDO (index:int, attachment:int, client:Boolean) :DisplayObject {
			var minion:IMinion = getTarget(index, attachment, client);
			var minionDO:DisplayObject;
			if (minion) {
				minionDO = minion.asDO();
			}
			return minionDO;
		}
	}

}