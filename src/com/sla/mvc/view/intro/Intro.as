package com.sla.mvc.view.intro 
{
	import com.sla.event.IntroEvent;
	import starling.display.DisplayObject;
	
	import com.sla.event.starling.StarlingIntroEvent;
	import com.sla.mvc.view.StarlingRobotlegsSprite;
	import com.sla.theme.LastArgumentTheme;
	import com.transform.Transform;
	import feathers.controls.ButtonGroup;
	import feathers.controls.List;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScrollContainer;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import flash.display.Bitmap;
	import flash.events.IEventDispatcher;
	import starling.display.Image;
	import starling.text.TextField;
	import starling.textures.Texture;
	//import feathers.themes.MinimalDesktopTheme;
	//import feathers.themes.MetalWorksDesktopTheme;
	import starling.events.Event;
	import starling.display.Quad;
	import feathers.themes.StyleNameFunctionTheme;
	import feathers.controls.Button;
	import com.demonsters.debugger.MonsterDebugger;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Intro extends Sprite
	{
		
		private var stageWidth:int;
		private var stageHeight:int;
		private var initFlag:Boolean = false;
		
		private var group:ButtonGroup;
			
		[Embed(source = "../../../../../../lib/assets/scout.jpg")]
		private var Background:Class;
		
		[Embed(source = "../../../../../../lib/assets/mandala2.png")]
		private var Logo:Class;
				
		public function Intro() 
		{
			super();
			addEventListener (Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
		}
		
		private function onAddedToStage (event:Event) :void {
			if (!initFlag) {
				init ();
			}
		}
		
		private function onSelectGame (event:Event) :void {
			dispatchEvent(new StarlingIntroEvent(StarlingIntroEvent.SELECT_GAME));
			completeAnimation();
		}
		
		private function onSelectCollection (event:Event) :void {
			dispatchEvent(new StarlingIntroEvent(StarlingIntroEvent.SELECT_COLLECTION));
			completeAnimation();
		}
		
		private function onSelectHeroes (event:Event) :void {
			dispatchEvent(new StarlingIntroEvent(StarlingIntroEvent.SELECT_HEROES));
			completeAnimation();
		}
		
		private function completeAnimation () :void {
			dispatchEvent(new StarlingIntroEvent(StarlingIntroEvent.COMPLETE));
		}
		
		private function init () :void {
			
			// backgroundImage
			var backgroundBitmap:Bitmap = new Background() as Bitmap;
			backgroundBitmap = Transform.toSize (backgroundBitmap, stageWidth, stageHeight);
			var backgroundTexture:Texture = Texture.fromBitmap(backgroundBitmap, false) 
			var backrgound:Image = new Image(backgroundTexture);
			this.addChild(backrgound);
			
			// copyright + mandala
			var logoBitmap:Bitmap = new Logo() as Bitmap;
			var logoTexture:Texture = Texture.fromBitmap(logoBitmap, false) 
			var logo:Image = new Image(logoTexture);
			this.addChild(logo);
			
			logo.x = -70;
			logo.y = stageHeight - 190;
			
			var legend:TextField = new TextField(500, 50, "Last Argument :: Montevideo :: 09.09.2274 :: Indico Games",
			"Arial", 10, 0);
			addChild (legend);
			legend.bold = true;
			legend.x = -100;
			legend.y = stageHeight - 35;
			
			// menu items
			group = new ButtonGroup(); 
			group.customButtonStyleName = "mainButton";
			group.useHandCursor = true;
			this.addChild(group);
			
			group.direction = ButtonGroup.DIRECTION_VERTICAL;
			group.gap = 1;
						
			group.dataProvider = new ListCollection(
			[
				{ label: "MATCHES", triggered: onSelectGame },
				{ label: "COLLECTION", triggered: onSelectCollection },
				{ label: "HEROES", triggered: onSelectHeroes },
			]);
			
			group.validate();
			
			group.x = (stageWidth - group.width >> 1) - 200;
			group.y = (stageHeight - group.height >> 1) - 100;
			
			initFlag = true;
		}
		
		
	}

}