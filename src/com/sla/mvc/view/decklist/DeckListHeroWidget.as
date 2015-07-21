package com.sla.mvc.view.decklist 
{
	import com.sla.mvc.model.data.HeroData;
	import com.sla.theme.Assets;
	import com.transform.Transform;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.display.Scale9Image;
	import feathers.layout.HorizontalLayout;
	import feathers.controls.TextArea;
	import flash.display.Bitmap;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class DeckListHeroWidget extends Sprite 
	{
		private var _initFlag:Boolean = false;
		private var background:Quad;
		private var achieves:LayoutGroup;
		private var labelField:TextField;
		private var descriptionField:TextArea;
		private var nameField:TextField;
		private var levelField:TextField;
		private var levelAsset:Image;
		
		[Embed(source="../../../../../../lib/assets/level.png")]
		private var Level:Class;
		
		private var luc:Image;
		
		public function DeckListHeroWidget() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		private function onAddedToStage(event:Event) :void {
			if (!_initFlag) {
				init();
			}
		}
		
		private function init () :void {
			background = new Quad(181, 280, 0xFFCC00);
			var achievesLayout:HorizontalLayout = new HorizontalLayout();
			achievesLayout.gap = 5;
			achievesLayout.paddingLeft = 0;
			achievesLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			achieves = new LayoutGroup();
			achieves.layout = achievesLayout;
			achieves.width = 180;
			achieves.y = 95;
			
			var b:Bitmap = new Level() as Bitmap;
			//b.bitmapData.transparent = true;
			var textute:Texture = Texture.fromBitmap(b);
			levelAsset = new Image(textute);
			levelAsset.x = 42;
			levelAsset.y = 165;
						
			nameField = new TextField(180, 30, "", "SupriaSans", 14);
			nameField.bold = true;
			nameField.color = 0;
			nameField.y = 125;
			
			levelField = new TextField(180, 30, "", "SupriaSans", 16);
			levelField.bold = true;
			levelField.color = 0;
			levelField.y = 150;
			
			labelField = new TextField(180, 30, "", "SupriaSans", 12);
			labelField.bold = true;
			labelField.color = 0;
			labelField.y = 185;
			
			descriptionField = new TextArea();
			descriptionField.width = 140;
			descriptionField.height = 70;
			descriptionField.x = 20;
			descriptionField.isEditable = false;
			//descriptionField.color = 0;
			descriptionField.y = 215;
			
		}
		
		public function setHero (heroData:HeroData) :void {
			removeChildren();
			addChild(background);
			addChild(levelAsset);
			achieves.removeChildren();
			
			var texture:Texture = Assets.getHeroAssetById(heroData.uid); 
			var asset:Image = new Image(texture);
			asset.x = 30;
			asset.y = - 30;
			addChild(asset); 
			
			addChild(achieves);
			for (var i:int = 0; i < 4; i ++) {
				var quad:Quad = new Quad(30, 30, 0x222222);
				achieves.addChild(quad);
			}
			
			addChild(nameField);
			nameField.text = heroData.title;
			
			addChild(labelField);
			labelField.text = heroData.vocation;
			
			addChild(descriptionField);
			descriptionField.text = heroData.description;
			
			addChild(levelField);
			levelField.text = heroData.level.toString();
		}
		
	}

}