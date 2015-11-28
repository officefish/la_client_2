package com.sla.mvc.controller.match.scenario.action.minion 
{
	import com.greensock.TweenLite;
	import com.sla.event.FieldEvent;
	import com.sla.mvc.view.card.Card;
	import com.sla.mvc.view.field.minion.IMinion;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ShowMirrorCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:FieldEvent;
		
		[Inject]
		public var scene:Scene;
		
		override public function execute():void 
		{
			
			
			var minion:IMinion = event.data.minion;
			var card:Sprite = minion.getCard().getMirror();
			var minionDO:DisplayObject = minion as DisplayObject;
			var position:Point = new Point(minionDO.x, minionDO.y);
			position = minionDO.parent.localToGlobal(position);
			
			var cardPosition:Point = new Point(position.x, position.y);
			if (position.x >= contextView.stage.stageWidth / 2) {
				cardPosition.x -= 120;
			} else {
				cardPosition.x += 120;
			}
			
			card.alpha = 0;
			card.x = cardPosition.x;
			card.y = cardPosition.y;
			scene.addPreview(card);
			
			TweenLite.to (card, 0.7, { alpha:1, delay:1 } );
		}
		
	}

}