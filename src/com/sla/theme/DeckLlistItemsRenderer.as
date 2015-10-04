package com.sla.theme 
{
	import com.demonsters.debugger.MonsterDebugger;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.display.Quad;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckLlistItemsRenderer extends LayoutGroupListItemRenderer  
	{
		private static const DEFAULT_BG_COLOR:uint = 0xb5bcbe;
		private var background:Quad;
		
		private var priceLabel:Label;
		private var titleLabel:Label;
		private var countLabel:Label;
		
		private var _id:int;
		
		
		public function DeckLlistItemsRenderer()  
		{
			
		}
		
		public function set id (value:int) :void {
			this._id = value;
		}
		
		public function get id () :int {
			return _id;
		}
		
		override protected function initialize():void
		{
			this.layout = new AnchorLayout(); 
			
			background = new Quad (this.width, this.height, DEFAULT_BG_COLOR);
			this.addChild(background);
			
			priceLabel = new Label();
			priceLabel.width = 30;
			priceLabel.styleNameList.add("deckListSlotPriceLabel");
			priceLabel.layoutData = DeckLlistItemsRenderer.priceLayout;
			this.addChild(priceLabel);
			
			titleLabel = new Label();
			titleLabel.width = this.width - 70;
			titleLabel.styleNameList.add("deckListSlotTitleLabel");
			titleLabel.layoutData = DeckLlistItemsRenderer.titleLayout;
			this.addChild(titleLabel);
			
			countLabel = new Label();
			countLabel.styleNameList.add("deckListSlotCountLabel");
			countLabel.layoutData = DeckLlistItemsRenderer.countLayout;
			this.addChild(countLabel);
			
			this.useHandCursor = true;
			
			this.addEventListener(TouchEvent.TOUCH, onTouch); 
			
		}
		
		private function onTouch (event:TouchEvent) :void { 
			if (event.getTouch(this, TouchPhase.BEGAN))
			{
				this.isSelected = true;
			}
		}
		
		
		override protected function commitData():void
        {
			if(this._data && this._owner)
            {
				titleLabel.text = this._data.title;
				priceLabel.text = this._data.price;
				if (this._data.count > 1) {
					countLabel.text = this._data.count;
				}
				this.id = this._data.id;
			}
		}
		
		
		private static var _priceLayoutData:AnchorLayoutData;
		private static function get priceLayout () :AnchorLayoutData {
			if (_priceLayoutData == null) {
				_priceLayoutData = new AnchorLayoutData();
				_priceLayoutData.top = 5;
			}
			return _priceLayoutData;
		}
		private static var _titleLayoutData:AnchorLayoutData;
		private static function get titleLayout () :AnchorLayoutData {
			if (_titleLayoutData == null) {
				_titleLayoutData = new AnchorLayoutData();
				_titleLayoutData.top = 7;
				_titleLayoutData.left = 35;
			}
			return _titleLayoutData;
		}
		private static var _countLayoutData:AnchorLayoutData;
		private static function get countLayout () :AnchorLayoutData {
			if (_countLayoutData == null) {
				_countLayoutData = new AnchorLayoutData();
				_countLayoutData.top = 5;
				_countLayoutData.right = 10;
			}
			return _countLayoutData;
		}
		
	}

}