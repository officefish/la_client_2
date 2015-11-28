package com.sla.mvc.controller.collection 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.greensock.easing.Expo;
	import com.greensock.TweenLite;
	import com.sla.event.ApiServiceEvent;
	import com.sla.mvc.model.CollectionModel;
	import com.sla.mvc.model.data.CollectionCardData;
	import com.sla.mvc.view.card.CollectionCard;
	import com.sla.mvc.view.collection.Collection;
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
	public class CardCreatedCommand extends StarlingCommand 
	{
		
		[Inject]
		public var event:ApiServiceEvent; 
		
		[Inject]
		public var collection:Collection;
		
		[Inject]
		public var model:CollectionModel;
		
		[Inject]
		public var craftWidget:CraftWidget;
		
		[Inject]
		public var scene:Scene;
		
		private var position:Point;
		
		private var card:CollectionCard;
		
		
		override public function execute():void 
		{
			MonsterDebugger.log('CardCreatedCommand::execute()');
			
			model.dust = event.data.dust;
			collection.setDust (event.data.dust);
					
			card = model.drawingCard;
			var mirror:Sprite = card.mirror; 
			var mirrorX:int = mirror.x;
			var mirrorY:int = mirror.y;
			var parent:Sprite = mirror.parent as Sprite;
			parent.removeChild (mirror);
						
			card.setState (0);
			mirror = card.mirror;
			parent.addChild (mirror);
			mirror.x = mirrorX;
			mirror.y = mirrorY;
			
			card.getCardData().setCount (event.data.count);
			
			card.mirror.useHandCursor = true;
			mirror.removeEventListeners();
			position = new Point(card.x, card.y);
			position = card.parent.localToGlobal(position);
			mirror.addEventListener(TouchEvent.TOUCH, onTouch); 

			card.showCount();
			collection.restateCards ();
			
			var craftAvailable:Boolean = (card.getCardData() as CollectionCardData).isCraftAvailable();
			if (craftAvailable) { 
				craftWidget.setState (1);
			} else {
				craftWidget.setState (0);
			}
			var golden:Boolean = card.getCardData().isGolden();
			var craftPrice:int = card.getCardData().getBuyCost();
			var destroyPrice:int = card.getCardData().getSaleCost();
			if (golden) {
				craftWidget.setPrices (craftPrice * 2,destroyPrice * 2);
			} else {
				craftWidget.setPrices (craftPrice,destroyPrice);
			}
			
			var dust:int = model.dust;
			if (dust < craftPrice || card.getCardData().getCount() > 1) {
				craftWidget.blockCraftButton();
			}
			
			if (card.getCardData().getCount() < 1) {
				craftWidget.blockDestroyButton();
			}
			
			if (golden) {
				if (card.getCardData().getCount() >= card.getCardData().getMaxGolden()) {
					craftWidget.blockCraftButton();
				}
			} else {
				if (card.getCardData().getCount() >= card.getCardData().getMaxSimple()) {
					craftWidget.blockCraftButton();
				}
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
			card.mirror.removeEventListener(TouchEvent.TOUCH, onTouch);
			TweenLite.to (card.mirror, 0.5, { scaleX:0.55, scaleY:0.55, alpha:0.7, x:position.x, y:position.y, ease:Expo.easeIn, onComplete:onTweenComplete } )
		}
		
		private function onTweenComplete () :void {
			scene.removeDarken();
			contextView.removeChild(scene);
			contextView.removeChild(card.mirror);
			card.mirror.alpha = 1;
			collection.stopBlur();
		}
		
		
	}

}