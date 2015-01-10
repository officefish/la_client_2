package com.la.mvc.view.collection 
{
	import com.hurlant.util.der.OID;
	import com.la.assets.Assets;
	import com.la.event.CollectionEvent;
	import com.la.mvc.model.DeckData;
	import com.transform.Transform;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckSlot extends Sprite 
	{
		
		private var titleLabel:TextField;
		private var complicatedLabel:TextField;
		
		private var shirme:Sprite;
		
		private var data:DeckData;
		
		private var removeBtn:RemoveDeckBtn;
		
		public function DeckSlot(deckData:DeckData) 
		{
			this.data = deckData;
			
			buttonMode = true;
			
			graphics.beginFill (0xCCCCCC);
			graphics.drawRect (0, 0, 180, 54);
			graphics.endFill ();
			
			
			var asset:Bitmap = Assets.getHeroAssetById(deckData.uid);
			asset = Transform.scale (asset, this.width / asset.width);
			asset = Transform.crop (asset, new Rectangle (0,0, 180, 54));
			addChild(asset); 
			
			shirme = new Sprite ();
			shirme.graphics.beginFill (0x222222, 0.5);
			shirme.graphics.drawRect (0,0, this.width, this.height);
			shirme.graphics.endFill();
			addChild (shirme);
			
			
			titleLabel = new TextField ();
			titleLabel.defaultTextFormat = DeckSlot.titleFormat;
			titleLabel.width = this.width;
			titleLabel.y = 24;
			titleLabel.height = 25;
			titleLabel.mouseEnabled = false;
			titleLabel.text = deckData.title;
			addChild(titleLabel);
			
			if (!deckData.complicated) {
				complicatedLabel = new TextField();
				complicatedLabel.defaultTextFormat = DeckSlot.complicatedFormat;
				complicatedLabel.width = this.width;
				complicatedLabel.y = 5;
				complicatedLabel.height = 20;
				complicatedLabel.mouseEnabled = false; 
				complicatedLabel.text = 'не собрана';
				addChild(complicatedLabel);
				
			}
			
			removeBtn = new RemoveDeckBtn ();
			removeBtn.addEventListener (MouseEvent.CLICK, onRemoveClick);
			removeBtn.x = this.width - removeBtn.width + 5;
			removeBtn.y = 5;
			
			addEventListener (MouseEvent.MOUSE_OVER, onMouseOver);
			addEventListener (MouseEvent.MOUSE_OUT, onMouseOut);
			addEventListener (MouseEvent.CLICK, onItemClick);
						
		}
		
		private function onItemClick (event:MouseEvent) :void {
			if (event.target is DeckSlot) {
				dispatchEvent (new CollectionEvent (CollectionEvent.EDIT_DECK, { deckData:data } ));
			}
		}
		
		private function onRemoveClick (event:MouseEvent) :void {
			dispatchEvent (new CollectionEvent (CollectionEvent.REMOVE_DECK, { deckData:data } ));
		}
		
		private function onMouseOver (event:MouseEvent) :void {
			if (contains(shirme)) removeChild (shirme);
			addChild (removeBtn);
		}
		
		private function onMouseOut (event:MouseEvent) :void {
			addChildAt (shirme, 1);
			if (contains(removeBtn)) removeChild (removeBtn);
		}
		
		private static var _titleFormat:TextFormat;
		private static function get titleFormat () :TextFormat {
			if (!_titleFormat) {
				_titleFormat = new TextFormat();  
				_titleFormat.align = TextFormatAlign.CENTER;
				_titleFormat.color = 0xEEEEEE;
				_titleFormat.size = 16;
				_titleFormat.bold = true;
			}
			return _titleFormat;
		}
		
		private static var _complicatedFormat:TextFormat;
		private static function get complicatedFormat () :TextFormat {
			if (!_complicatedFormat) {
				_complicatedFormat = new TextFormat();  
				_complicatedFormat.align = TextFormatAlign.CENTER;
				_complicatedFormat.color = 0xFF0000;
				_complicatedFormat.size = 11;
			}
			return _complicatedFormat;
		}
		
	}

}