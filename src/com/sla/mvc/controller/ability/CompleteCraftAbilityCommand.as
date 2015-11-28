package com.sla.mvc.controller.ability 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import com.sla.mvc.view.ability.AbilityCraftCard;
	import com.sla.mvc.view.collection.CraftWidget;
	import com.sla.mvc.view.scene.Scene;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CompleteCraftAbilityCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject]
		public var model:CollectionModel;
		
		private var preview:Sprite;
		private var position:Point;
		
		[Inject]
		public var browser:AbilityBrowser; 
		
		[Inject]
		public var craftWidget:CraftWidget; 
		
		[Inject] 
		public var scene:Scene;
		
		override public function execute():void 
		{
			MonsterDebugger.log ('CompleteCraftAbilityCommand::execute()');
			//MonsterDebugger.log ('dust:' + event.data.dust);
			model.dust = event.data.dust;
			browser.setDust(model.dust);
			//
			var ability:AbilityCraftCard = model.drawingAbility;
			position = new Point(ability.x, ability.y);
			position = ability.parent.localToGlobal(position);
			preview = ability.getPreview();
			var previewPosition:Point = new Point (preview.x, preview.y);
			preview.removeEventListeners();
			preview.useHandCursor = true;
			preview.parent.removeChild(preview);
			ability.getData().count = 1;
			ability.setState(0); 
			preview = ability.getPreview();
			preview.x = previewPosition.x;
			preview.y = previewPosition.y;
			contextView.addChild(preview);
			preview.addEventListener(TouchEvent.TOUCH, onTouch);
			
			//if (dust < craftPrice || card.getData().count) {
			
			craftWidget.setState (1);
			craftWidget.blockCraftButton();
			//}
			
		}
		
		private function onTouch(event:TouchEvent) :void { 
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.BEGAN))  
			{
				endPreview(); 
			}
		}
		
		private function endPreview () :void {
			if (contextView.contains(craftWidget)) {
				contextView.removeChild(craftWidget); 
			}
			preview.removeEventListener(TouchEvent.TOUCH, onTouch); 
			TweenLite.to (preview, 0.5, { scaleX:0.55, scaleY:0.55, alpha:0.7, x:position.x, y:position.y, ease:Expo.easeIn, onComplete:onTweenComplete } )
		
		}
		
		private function onTweenComplete () :void {
			scene.removeDarken();
			contextView.removeChild(scene);
			contextView.removeChild(preview);
			preview.alpha = 1;
			browser.stopBlur();
		}
		
	}

}