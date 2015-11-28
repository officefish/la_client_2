package com.sla.mvc.controller.ability 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.AbilityEvent;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.view.ability.AbilityBrowser;
	import com.sla.mvc.view.ability.AbilityCraftCard;
	import com.sla.mvc.view.collection.CraftWidget;
	import flash.geom.Point;
	import org.robotlegs.mvcs.StarlingCommand;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import com.sla.mvc.view.scene.Scene;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class PreviewCraftAbilityCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:AbilityEvent;
		
		[Inject]
		public var craftWidget:CraftWidget; 
		
		[Inject]
		public var model:CollectionModel; 
		
		[Inject]
		public var scene:Scene;
		
		private var position:Point;
		private var preview:Sprite;
		
		[Inject]
		public var abilityBrowser:AbilityBrowser;
		
		
		override public function execute():void 
		{
			MonsterDebugger.log ('PreviewCraftAbilityCommand::execute()');
			var card:AbilityCraftCard = event.data.card;
			preview = card.getPreview();
			
			abilityBrowser.blur();
			
			model.drawingAbility = card;
						
			contextView.addChild(scene);
			scene.resize(contextView.stage.stageWidth, contextView.stage.stageHeight);
			scene.darken();
			//collection.blur();
			contextView.addChild(preview);
			
			var endPosition:Point = new Point ();
			endPosition.x = contextView.stage.stageWidth / 2 - 100;
			endPosition.y = contextView.stage.stageHeight / 2;
			
			position = new Point(card.x, card.y);
			position = card.parent.localToGlobal(position);
			
			preview.x = position.x;
			preview.y = position.y;
			preview.scaleX = 0.55;
			preview.scaleY = 0.55;
			preview.useHandCursor = true;
			preview.addEventListener(TouchEvent.TOUCH, onTouch); 
			
			TweenLite.to (preview, 0.5, { scaleX:1.0, scaleY:1.0, x:endPosition.x, y:endPosition.y, ease:Expo.easeOut } )

			contextView.addChild(craftWidget);
			craftWidget.y = endPosition.y + 175;
			craftWidget.x = endPosition.x - 121;
				
			
			craftWidget.setState (1);
			
				
			var craftPrice:int = card.getData().buyCost;
			var destroyPrice:int = card.getData().saleCost;
			craftWidget.setPrices (craftPrice,destroyPrice);
				
			var dust:int = model.dust;
			if (dust < craftPrice || card.getData().count) {
				craftWidget.blockCraftButton();
			}
			if (!card.getData().count) {
				craftWidget.blockDestroyButton();
			}
			
		}
		
		private function onTouch (event:TouchEvent) :void {
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
			abilityBrowser.stopBlur();
			//collection.stopBlur();
		}
		
	}

}