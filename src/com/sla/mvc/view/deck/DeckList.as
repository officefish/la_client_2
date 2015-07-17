package com.sla.mvc.view.deck 
{
	import com.sla.event.starling.StarlingDeckListEvent;
	import com.sla.mvc.model.data.DeckData;
	import com.transform.Transform;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledColumnsLayout;
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.display.Quad;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckList extends Sprite 
	{
		
		private var stageWidth:int;
		private var stageHeight:int;
		private var initFlag:Boolean = false;
		private var deckItemGroup:LayoutGroup;
		
		private var introGroup:LayoutGroup;
		
		private static const ITEM_GROUP_GAP:int = 10;
		private static const ITEM_GROUP_PADDING:int = 10;
		private static const ITEM_GROUP_PADDING_TOP:int = 20;
		private static const ITEM_GROUP_WIDTH:int = 450;
		private static const ITEM_GROUP_HEIGHT:int = 420;
		private static const CONTAINER_WIDTH:int = 680;
		private static const DECK_INTRO_WIDTH:int = 219;
		private static const CONTAINER_ALPHA:Number = 0.6;
		
		[Embed(source = "../../../../../../lib/assets/titanfall.png")]
		private var Background:Class;
		
		public function DeckList() 
		{
			this.addEventListener (Event.ADDED_TO_STAGE, onAddedToStage);			
		}
		
		private function onAddedToStage (event:Event) :void {
			if (!initFlag) {
				init();
			}
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
		}
		
		private function init () :void {
			// backgroundImage 
			var backgroundBitmap:Bitmap = new Background() as Bitmap;
			backgroundBitmap = Transform.toSize (backgroundBitmap, stageWidth, stageHeight);
			var backgroundTexture:Texture = Texture.fromBitmap(backgroundBitmap, false) 
			var backrgound:Image = new Image(backgroundTexture);
			this.addChild(backrgound);
			
			var container:LayoutGroup = new LayoutGroup ();
			this.addChild(container);
			
			container.width = CONTAINER_WIDTH;
			container.height = ITEM_GROUP_HEIGHT;
			
			var decksContainer:Sprite = new Sprite();
						
			var quad:Quad = new Quad( ITEM_GROUP_WIDTH, ITEM_GROUP_HEIGHT, 0);
			quad.alpha = CONTAINER_ALPHA;
			decksContainer.addChild(quad);
			
			deckItemGroup = new LayoutGroup ();
			deckItemGroup.width = ITEM_GROUP_WIDTH;
			deckItemGroup.height = ITEM_GROUP_HEIGHT;
			
			var deckItemGroupLayout:TiledColumnsLayout = new TiledColumnsLayout();
			
			deckItemGroupLayout.horizontalGap = ITEM_GROUP_GAP;
			deckItemGroupLayout.verticalGap = ITEM_GROUP_GAP;
			
			deckItemGroupLayout.paddingTop = ITEM_GROUP_PADDING_TOP;
			deckItemGroupLayout.paddingLeft = ITEM_GROUP_PADDING;
			deckItemGroupLayout.paddingRight = ITEM_GROUP_PADDING;
			deckItemGroupLayout.paddingBottom = ITEM_GROUP_PADDING;
			
			
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
			
			var closeButton:Button = new Button();
			closeButton.styleNameList.add('closeView');
			var cbLayoutData:AnchorLayoutData = new AnchorLayoutData();
			cbLayoutData.right = 0;
			cbLayoutData.top = 0;
			closeButton.layoutData = cbLayoutData;
			introGroup.addChild(closeButton);
			closeButton.addEventListener( Event.TRIGGERED, onClose);
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 1; 
			container.layout = layout;
			
			container.validate();
			
			container.x = (stageWidth - container.width >> 1) + 100;
			container.y = (stageHeight - container.height >> 1) - 30;
				
			
		}
		
		private function onClose (event:Event) :void {
			dispatchEvent(new StarlingDeckListEvent(StarlingDeckListEvent.CLOSE));
		}
		
		public function initDecks (decks:Vector.<DeckData>) :void {
			deckItemGroup.removeChildren();
			var length:int = decks.length;
			var item:DeckListItem;
			for (var i:int = 0; i < length; i ++) {
				item = new DeckListItem((decks[i]) as DeckData);
				deckItemGroup.addChild(item);
			}
		}
	}

}