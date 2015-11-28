package com.sla.mvc.view.collection.heroes 
{
	import com.la.mvc.view.collection.NewDeckButton;
	import com.sla.event.starling.HeroListItemEvent;
	import com.sla.event.starling.StarlingCollectionEvent;
	import com.sla.mvc.view.decklist.DeckListHeroWidget;
	import com.transform.Transform;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledColumnsLayout;
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroesView extends Sprite 
	{
		
		private static const ITEM_GROUP_GAP:int = 10;
		private static const ITEM_GROUP_PADDING:int = 10;
		private static const ITEM_GROUP_PADDING_TOP:int = 20;
		private static const ITEM_GROUP_WIDTH:int = 450;
		private static const ITEM_GROUP_HEIGHT:int = 420;
		private static const CONTAINER_WIDTH:int = 680;
		private static const DECK_INTRO_WIDTH:int = 219;
		private static const CONTAINER_ALPHA:Number = 0.6;
		
		[Embed(source="../../../../../../../lib/assets/titanfall.png")]
		private var Background:Class;
				
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var container:LayoutGroup;
		private var deckItemGroup:LayoutGroup;
		private var background:Image;
		private var introGroup:LayoutGroup;
		
		private var actualItem:HeroesListItem;
		private var widget:DeckListHeroWidget;
		
		private var heroButton:Button; 

		
		public function HeroesView() 
		{
			container = new LayoutGroup ();
			container.width = CONTAINER_WIDTH;
			container.height = ITEM_GROUP_HEIGHT;
			
			var layout:HorizontalLayout = new HorizontalLayout(); 
			layout.gap = 1; 
			container.layout = layout;
			
			
			var decksContainer:Sprite = new Sprite();
						
			var quad:Quad = new Quad( ITEM_GROUP_WIDTH, ITEM_GROUP_HEIGHT, 0);
			quad.alpha = CONTAINER_ALPHA;
			decksContainer.addChild(quad);
						
			var deckItemGroupLayout:TiledColumnsLayout = new TiledColumnsLayout(); 
			
			deckItemGroupLayout.horizontalGap = ITEM_GROUP_GAP;
			deckItemGroupLayout.verticalGap = ITEM_GROUP_GAP;
			
			deckItemGroupLayout.paddingTop = ITEM_GROUP_PADDING_TOP;
			deckItemGroupLayout.paddingLeft = ITEM_GROUP_PADDING;
			deckItemGroupLayout.paddingRight = ITEM_GROUP_PADDING;
			deckItemGroupLayout.paddingBottom = ITEM_GROUP_PADDING;
			
			deckItemGroup = new LayoutGroup ();
			deckItemGroup.width = ITEM_GROUP_WIDTH;
			deckItemGroup.height = ITEM_GROUP_HEIGHT;
			
			deckItemGroup.layout = deckItemGroupLayout;
			decksContainer.addChild(deckItemGroup);
			
			container.addChild(decksContainer);
			
			introGroup = new LayoutGroup ();
			var introGroupLayout:AnchorLayout = new AnchorLayout();
			introGroup.layout = introGroupLayout;
			
			var quad2:Quad = new Quad( DECK_INTRO_WIDTH, ITEM_GROUP_HEIGHT, 0);
			quad2.alpha = CONTAINER_ALPHA;
			introGroup.addChild(quad2);
			container.addChild(introGroup);
			
			widget = new DeckListHeroWidget();
			widget.y = 40;
			widget.x = 19; 
			
			heroButton = new Button();
			heroButton.useHandCursor = true;
			heroButton.addEventListener ( Event.TRIGGERED, onReady);
			heroButton.label = 'READY';
			heroButton.styleNameList.add('mainButton');
			heroButton.x = 5;
			heroButton.y = 330; 
						
			this.addEventListener (HeroListItemEvent.SELECT, onSelect);
			
			
		}
		
		private function onReady (event:Event) :void {
			var id:int = actualItem.getData().id;
			parent.dispatchEvent(new StarlingCollectionEvent(StarlingCollectionEvent.HERO_DELECT, false, {'heroId':id}));
		}
		
		private function onSelect (event:HeroListItemEvent) :void {
			
			if (actualItem) {
				actualItem.selected = false;
			}
			actualItem = event.target as HeroesListItem;
			actualItem.selected = true;
			
			
			if (!introGroup.contains(widget)) {
				introGroup.addChild(widget);
			}
			widget.setHero (actualItem.getData());
			
			
			if (!introGroup.contains(heroButton)) {
				introGroup.addChild(heroButton);
			}
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			
			this.removeChildren();
			
			var backgroundBitmap:Bitmap = new Background() as Bitmap;
			backgroundBitmap = Transform.toSize (backgroundBitmap, stageWidth, stageHeight);
			var backgroundTexture:Texture = Texture.fromBitmap(backgroundBitmap, false) 
			background = new Image(backgroundTexture); 
			
			this.addChild(background);
			
			this.addChild(container);
			
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
			
			container.validate();
			
			container.x = (stageWidth - container.width >> 1) + 100;
			container.y = (stageHeight - container.height >> 1) - 30;
		}
		
		public function initHeroes (value:Array) :void {
			deckItemGroup.removeChildren();
			//this.decks = {};
			var length:int = value.length;
			var item:HeroesListItem;
			for (var i:int = 0; i < length; i ++) {
				item = new HeroesListItem(value[i]);
				deckItemGroup.addChild(item);
				//this.decks[deckDatas[i].id] = item;
			}
		}
		
	}

}