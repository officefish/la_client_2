package com.sla.mvc.controller.match.scenario.action.ability 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.TweenLite;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.view.field.FieldAbilitySlot;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreviewAbilityCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			MonsterDebugger.log('previewAbilityCommand::execute()');
			var slot:FieldAbilitySlot = event.data.slot;
			var card:Sprite = slot.getMirror();
			var position:Point = new Point(slot.x, slot.y);
			position = slot.parent.localToGlobal(position);
			
			var cardPosition:Point = new Point(position.x, position.y);
			if (slot.isEnemy) {
				cardPosition.y += 170;
			} else {
				cardPosition.y -= 170;
			}
						
			card.alpha = 0;
			card.x = cardPosition.x;
			card.y = cardPosition.y;
			scene.addPreview(card);
			
			TweenLite.to (card, 0.7, { alpha:1, delay:2 } ); 
		}
		
	}

}