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
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CompleteDustAbilityCommand extends StarlingCommand 
	{
		[Inject]
		public var event:ApiServiceEvent; 
		
		[Inject]
		public var model:CollectionModel; 
		
		[Inject]
		public var craftWidget:CraftWidget;
		
		[Inject] 
		public var scene:Scene;
		
		private var preview:Sprite;
		
		private var position:Point;
				
		[Inject]
		public var browser:AbilityBrowser; 
		
		override public function execute():void 
		{
			MonsterDebugger.log('CompleteDustAbilityCommand::execute()');
			MonsterDebugger.log ('dust:' + event.data.dust);
			model.dust = event.data.dust;
			browser.setDust(model.dust);
			
			var ability:AbilityCraftCard = model.drawingAbility; 
			position = new Point(ability.x, ability.y);
			position = ability.parent.localToGlobal(position);
			preview = ability.getPreview(); 
			var previewPosition:Point = new Point (preview.x, preview.y);
			preview.removeEventListeners();
			preview.useHandCursor = true;
			preview.parent.removeChild(preview);
			ability.getData().count = 0;
			ability.setState(1); 
			preview = ability.getPreview();
			preview.x = previewPosition.x;
			preview.y = previewPosition.y;
			contextView.addChild(preview);
			preview.addEventListener(TouchEvent.TOUCH, onTouch); 
			
			craftWidget.setState (1);
			craftWidget.blockDestroyButton();
			if (model.dust < ability.getData().buyCost) {
				craftWidget.blockCraftButton();
			}
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