package com.la.mvc.controller.collection 
{
	import com.la.event.ApiServiceEvent;
	import com.la.mvc.model.CollectionCardData;
	import com.la.mvc.model.CollectionModel;
	import com.la.mvc.view.card.Card;
	import com.la.mvc.view.card.CollectionCard;
	import com.la.mvc.view.collection.CraftWidget;
	import com.la.mvc.view.collection.ICollection;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class CardCreatedCommand extends Command 
	{
		[Inject (name='collectionModel')]
		public var model:CollectionModel; 
		
		[Inject]
		public var event:ApiServiceEvent;
		
		[Inject (name='collection')]
		public var collection:ICollection;
		
		[Inject (namespace = 'craftWidget')]
		public var craftWidget:CraftWidget; 
		
		override public function execute():void 
		{
			
			model.setDust (event.getData().dust);
			collection.setDust (event.getData().dust);
					
			var card:CollectionCard = model.collectionCard; 
			var mirror:Bitmap = model.getPreview(); 
			var mirrorX:int = mirror.x;
			var mirrorY:int = mirror.y;
			var parent:Sprite = mirror.parent as Sprite;
			parent.removeChild (mirror);
			
			card.setState (0);
			mirror = card.getMirrorBitmap();
			parent.addChild (mirror);
			model.setPreview (mirror);
			mirror.x = mirrorX;
			mirror.y = mirrorY;
			
			card.getCardData().setCount (event.getData().count);
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
			
			var dust:int = model.getDust();
			if (dust < craftPrice) {
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
	}

}