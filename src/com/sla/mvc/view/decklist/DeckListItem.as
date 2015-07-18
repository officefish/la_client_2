package com.sla.mvc.view.decklist {
	import com.sla.event.starling.DeckListItemEvent;
	import com.sla.theme.Assets;
	import flash.text.TextFormat;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import com.sla.mvc.model.data.DeckData;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.BlurFilter;
	import starling.filters.FragmentFilter;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListItem extends Sprite 
	{
		
		private var id:int;
		private var uid:int;
		private var hero_id:int;
		private var deckData:DeckData;
		
		private var disableQuand:Quad;
		private var labelQuad:Quad;
		private var labelLineQuad:Quad;
		
		private var label:TextField;
		
		private var notCompleteLabel:TextField;
		
		private var notCompleteQuad:Quad;
		
		private var _selected:Boolean = false;
		
		private var selectFormat:TextFormat;
		
		public function DeckListItem(deckData:DeckData) 
		{
			this.id = deckData.id;
			this.uid = deckData.uid;
			this.deckData = deckData;
			
			var texture:Texture = Assets.getHeroAssetById(uid); 
			var asset:Image = new Image(texture);
			addChild(asset);
			
			disableQuand = new Quad(120, 120);
			disableQuand.color = 0x222222;
			disableQuand.alpha = 0.7;
			addChild(disableQuand);
			
			notCompleteQuad = new Quad(120, 120);
			notCompleteQuad.color = 0xFF0000;
			notCompleteQuad.alpha = 0.7;
			notCompleteQuad.visible = false;
			addChild(notCompleteQuad);
			
			labelQuad = new Quad(100, 50);
			labelQuad.x = 10;
			labelQuad.y = 60;
			labelQuad.alpha = 0.5;
			labelQuad.color = 0;
			addChild(labelQuad);
			
			labelLineQuad = new Quad(1, 50);
			labelLineQuad.x = 10;
			labelLineQuad.y = 60;
			labelLineQuad.color = 0xFFFFFF;
			addChild(labelLineQuad);
			
			label = new TextField(100, 20, "", "SupriaSans", 11, 0xFFFFFF);
			label.hAlign="left";
			label.x = 20;
			label.y = labelQuad.y + 5;
			label.text = deckData.title;
			addChild(label);
						
			if (!deckData.complicated) {
				notCompleteLabel = new TextField(100, 20, "", "SupriaSans", 11, 0xFF0000);
				notCompleteLabel.hAlign="left";
				notCompleteLabel.x = 20;
				notCompleteLabel.y = labelQuad.y + 25;
				notCompleteLabel.text = "not complete";
				addChild(notCompleteLabel);
			}
			
			this.addEventListener(TouchEvent.TOUCH, onTouch); 
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (_selected) return;
			
			if (event.getTouch(this, TouchPhase.HOVER)) {
				disableQuand.visible = false;
				if (!deckData.complicated) {
					notCompleteQuad.visible = true;
				}
			} else {
				disableQuand.visible = true;
				notCompleteQuad.visible = false;
			}
			if (event.getTouch(this, TouchPhase.BEGAN))
			{
				disableQuand.visible = false;
                if (deckData.complicated) {
					notCompleteQuad.visible = false;
					dispatchEvent(new DeckListItemEvent(DeckListItemEvent.SELECT, true, null));

				} else {
					var data:Object = { }
					data.deckData = deckData;
					data.target = this;
					dispatchEvent(new DeckListItemEvent(DeckListItemEvent.EDIT_DECK, true, data));
					notCompleteQuad.visible = true;
				}
				this.removeEventListener(TouchEvent.TOUCH, onTouch); 
			}
			
			
		}
		
		public function cancelEdit () :void {
			this.addEventListener(TouchEvent.TOUCH, onTouch);
			notCompleteQuad.visible = false;
			disableQuand.visible = true;
		}
		
		public function set selected (value:Boolean) :void {
			_selected = value;
			if (value) {
				this.filter = blurFilter; 
				labelLineQuad.color = 0xFFCC00;
				this.removeEventListener(TouchEvent.TOUCH, onTouch);
				label.color = 0xFFCC00;
			} else {
				this.filter = null;
				labelLineQuad.color = 0xFFFFFF;
				this.addEventListener(TouchEvent.TOUCH, onTouch);
				label.color = 0xFFFFFF;
				disableQuand.visible = true;
			}
			
		}
		
		private static var _blurFilter:BlurFilter;
		private static function get blurFilter () :FragmentFilter {
			if (_blurFilter == null) {
				_blurFilter =  BlurFilter.createGlow(0xFFCC00,5,5,0.1);
				_blurFilter.blurX = 0;
				_blurFilter.blurY = 0; 
			}
			return _blurFilter;
		}
		
		public function getDeckData () :DeckData {
			return deckData;
		}
		
	}

}