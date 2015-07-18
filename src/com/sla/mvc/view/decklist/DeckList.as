package com.sla.mvc.view.decklist {
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.starling.DeckListItemEvent;
	import com.sla.event.starling.StarlingDeckListEvent;
	import com.sla.mvc.model.data.DeckData;
	import com.transform.Transform;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.LayoutGroup;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.TiledColumnsLayout;
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.FragmentFilter;
	import starling.filters.GodRaysFilter;
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
		
		private var editItem:DeckListItem;
		private var actualItem:DeckListItem;
		
		[Embed(source = "../../../../../../lib/assets/titanfall.png")]
		private var Background:Class;
		private var backrgound:Image;
		private var container:LayoutGroup;
		
		private var widget:DeckListHeroWidget;
		
		private var matchButton:Button;
		
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
			backrgound = new Image(backgroundTexture);
			this.addChild(backrgound);
			
			var godRaysFilter:GodRaysFilter = new GodRaysFilter();
			godRaysFilter.density = 3.8;
			godRaysFilter.exposure = 0.3;
			godRaysFilter.weight = 0.2;
			godRaysFilter.decay = 1.0;
			godRaysFilter.lightX = backrgound.width / 2;
			godRaysFilter.lightY = backrgound.height / 2;
			//backrgound.filter = godRaysFilter;
			
			
			container = new LayoutGroup ();
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
			closeButton.label = 'close';
			closeButton.styleNameList.add('closeView');
			var cbLayoutData:AnchorLayoutData = new AnchorLayoutData();
			cbLayoutData.right = 20;
			cbLayoutData.top = 2;
			closeButton.layoutData = cbLayoutData;
			introGroup.addChild(closeButton);
			closeButton.addEventListener( Event.TRIGGERED, onClose);
			
			matchButton = new Button();
			matchButton.addEventListener ( Event.TRIGGERED, onReady);
			matchButton.label = 'READY';
			matchButton.styleNameList.add('smallButton');
			matchButton.x = 50;
			matchButton.y = 355;
			
			var layout:HorizontalLayout = new HorizontalLayout();
			layout.gap = 1; 
			container.layout = layout;
			
			container.validate();
			
			container.x = (stageWidth - container.width >> 1) + 100;
			container.y = (stageHeight - container.height >> 1) - 30;
			
			initFlag = true;
			
			widget = new DeckListHeroWidget();
			widget.y = 60;
			widget.x = 19;
			
			this.addEventListener (DeckListItemEvent.EDIT_DECK, onEditDeck);
			this.addEventListener (DeckListItemEvent.SELECT, onSelect);
			
		}
		
		private function onReady (event:Event) :void {
			dispatchEvent(new StarlingDeckListEvent(StarlingDeckListEvent.READY));
		}
		
		private function onSelect (event:DeckListItemEvent) :void {
			if (actualItem) {
				actualItem.selected = false;
			}
			actualItem = event.target as DeckListItem;
			actualItem.selected = true;
			
			if (!introGroup.contains(widget)) {
				introGroup.addChild(widget);
			}
			widget.setHero (actualItem.getDeckData().hero);
			
			if (!introGroup.contains(matchButton)) {
				introGroup.addChild(matchButton);
			}
			
		}
		
		private function slaAlertFactory():Alert
		{
			var alert:Alert = new Alert();
			alert.styleNameList.add( "sla-alert" );
			return alert;
		};
		
		private function onEditDeck (event:DeckListItemEvent) :void {
			editItem = event.data.target;
			activateAlertFilters();
			
			Alert.show( "This deck is not complete. Do you want to edit it right now? ", "Warning", new ListCollection(
			[
				{ label: "Edit", triggered: editButton_triggeredHandler }, 
				{ label: "Cancel", triggered: cancelButton_triggeredHandler }
			]), null, true, true, slaAlertFactory );
			
			
			
			//dispatchEvent(new StarlingDeckListEvent(StarlingDeckListEvent.EDIT_DECK, false, event.data));
		}
		
		private function cancelButton_triggeredHandler (event:Event) :void {
			editItem.cancelEdit();
			deactivateAlertFilters();
		}
		
		private function editButton_triggeredHandler (event:Event) :void {
			deactivateAlertFilters();
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
		
		
		/* Alert filters */
		private function activateAlertFilters () :void {
			this.filter = DeckList.blurFilter;
			container.filter = DeckList.darkenFilter;
			backrgound.filter = DeckList.darkenFilter;
		}
		private function deactivateAlertFilters () :void {
			this.filter = null;
			container.filter = null;
			backrgound.filter = null;
		}
		private static var _blurFilter:BlurFilter;
		private static function get blurFilter () :FragmentFilter {
			if (_blurFilter == null) {
				_blurFilter = new BlurFilter();
			}
			return _blurFilter;
		}
		private static var _darkenFilter:ColorMatrixFilter;
		private static function get darkenFilter () :FragmentFilter {
			if (_darkenFilter == null) {
				_darkenFilter = new ColorMatrixFilter();
				_darkenFilter.adjustBrightness(-0.15);
			}
			return _darkenFilter;
		}
		/* end Alert filters */
	}

}