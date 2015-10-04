package com.sla.mvc.view.collection.deck 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.sla.event.starling.StarlingCollectionEvent;
	import com.sla.mvc.model.data.DeckData;
	import com.sla.theme.Assets;
	import com.transform.Transform;
	import feathers.controls.Label;
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import feathers.controls.Button;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckSlot extends Sprite 
	{
		
		private var titleLabel:Label;
		private var shirme:Sprite;
		private var complicatedLabel:Label;
		private var removeBtn:Button;
		private var deckData:DeckData;
			
		
		public function DeckSlot(data:DeckData) 
		{
			this.deckData = data;
			
			var q:Quad = new Quad(180, 54, 0xCCCCCC);
			addChild(q);
			
			this.useHandCursor = true;
			
			var asset:Bitmap = Assets.getHeroAssetBitmapById(data.uid); 
			asset = Transform.scale (asset, 180 / asset.width);
			asset = Transform.cropAndShift (asset, new Rectangle (0,0, 180, 54), 0, 0);
			
			var texture:Texture = Texture.fromBitmap(asset);
			var image:Image = new Image(texture);
			addChild(image); 
			
			shirme = new Sprite ();
			shirme.addChild(new Quad(180,54,0x222222));
			shirme.alpha = 0.7;
			addChild (shirme);
			
			titleLabel = new Label();
			titleLabel.width = 180;
			titleLabel.height = 35;
			titleLabel.y = 10;
			titleLabel.touchable = false;
			titleLabel.styleNameList.add('deckTitleLabel');
			titleLabel.text = data.title;
			addChild(titleLabel);
			
			if (!data.complicated) {
				complicatedLabel = new Label();
				complicatedLabel.width = 180;
				complicatedLabel.y = 30;
				complicatedLabel.height = 20;
				complicatedLabel.touchable = false;
				complicatedLabel.styleNameList.add('deckComplicatedLabel');
				complicatedLabel.text = 'not complete';
				addChild(complicatedLabel);
			}
			
			removeBtn = new Button ();
			removeBtn.styleNameList.add('removeDeckButton');
			//removeBtn.addEventListener (MouseEvent.CLICK, onRemoveClick);
			removeBtn.x = 160;
			removeBtn.y = 5;
			
			
			this.addEventListener (TouchEvent.TOUCH, onTouch); 
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.HOVER)) {
				shirme.alpha = 0.9;
				addChild(removeBtn);
			} else {
				shirme.alpha = 0.7;
				if (contains(removeBtn)) removeChild(removeBtn);
			}
			if (event.getTouch(event.currentTarget as DisplayObject, TouchPhase.BEGAN)) {
				shirme.alpha = 0.9;
				addChild(removeBtn);
				if (event.target == removeBtn) {
					dispatchEvent (new StarlingCollectionEvent (StarlingCollectionEvent.REMOVE, false, { deckData:deckData } ));
				} else {
					dispatchEvent (new StarlingCollectionEvent (StarlingCollectionEvent.EDIT, false, { deckData:deckData } ));
				}
			} 
		}
		
	}

}