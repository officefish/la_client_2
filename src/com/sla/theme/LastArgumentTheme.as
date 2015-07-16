package com.sla.theme 
{
	import com.greensock.layout.ScaleMode;
	import com.la.mvc.view.collection.NewDeckButton;
	import feathers.controls.Button;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import feathers.themes.StyleNameFunctionTheme;
	import flash.geom.Rectangle;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.Font;
	import flash.text.TextFormat;
	import mx.core.FontAsset;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LastArgumentTheme extends StyleNameFunctionTheme 
	{
		
		[Embed(source="../../../../lib/la_theme_assets/la_map.atf", mimeType="application/octet-stream")]
		private static const ATLAS_BITMAP:Class;

		[Embed(source="../../../../lib/la_theme_assets/la_map.xml", mimeType="application/octet-stream")]
		private static const ATLAS_XML:Class;
		
		[Embed(source = "../../../../lib/fonts/After_Disaster.ttf", 
		fontName = "AfterDisaster", 
		mimeType = "application/x-font-truetype", 
		advancedAntiAliasing="true",
		embedAsCFF="false")]
		public static var AfterDisaster:Class;
		
		[Embed(source = "../../../../lib/fonts/F-ck Beans Bold.ttf",
		fontName = "FckBeans", 
		mimeType = "application/x-font-truetype", 
		advancedAntiAliasing="true",
		embedAsCFF="false")]
		public static var FckBeans:Class;
		
		[Embed(source = "../../../../lib/fonts/Casual Hardcore.otf",
		fontName = "CasualHardcore", 
		mimeType = "application/x-font-truetype", 
		advancedAntiAliasing="true",
		embedAsCFF="false")]
		public static var CasualHardcore:Class;
		
		private var atlas:TextureAtlas; 
		
		public function LastArgumentTheme() 
		{
			super();
			this.createTextureAtlas();
			this.initialize();
		}
		
		private function initialize():void
        {
			//var font:Font = new FontAsset.FontAfterDisaster();
			initializeGlobals();
			initializeStyleProviders ();
        }
		
		private function initializeStyleProviders():void
		{
			// button
			this.getStyleProviderForClass( Button ).defaultStyleFunction = this.setButtonStyles;
		}
		
		private function createTextureAtlas():void
		{
			var atlasTexture:Texture = Texture.fromEmbeddedAsset( ATLAS_BITMAP ); 
			var atlasXML:XML = XML( new ATLAS_XML() );
			this.atlas = new TextureAtlas( atlasTexture, atlasXML );
		}
		
		private function setButtonStyles( button:Button ):void
		{
			button.defaultSkin = new Scale9Image( 
			new Scale9Textures(this.atlas.getTexture( "btnDefault" ), new Rectangle(0,0,200,33))) as DisplayObject;
			button.downSkin = new Scale9Image( 
			new Scale9Textures(this.atlas.getTexture( "btnDown" ), new Rectangle(0,0,200,33))) as DisplayObject;
			button.hoverSkin = button.downSkin;
			
			button.padding = 20;
			button.gap = 15;
			button.paddingTop = 25;
			
			button.defaultLabelProperties.embedFonts = true; 
			button.defaultLabelProperties.textFormat = new TextFormat("CasualHardcore", 
			24, 0xffffff); 
			
			button.downLabelProperties.embedFonts = true;
			button.hoverLabelProperties.embedFonts = true;
			button.downLabelProperties.textFormat = 
			button.hoverLabelProperties.textFormat = new TextFormat("FckBeans", 
			24, 0x222222); 
		}
		
		private function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				var tr:TextFieldTextRenderer = new TextFieldTextRenderer();
				return tr; 
			};

			FeathersControl.defaultTextEditorFactory = function():ITextEditor
			{
				return new StageTextTextEditor();
			};
		}
		
		
		
	}

}