package com.sla.theme 
{
	import com.greensock.layout.ScaleMode;
	import com.la.mvc.view.collection.NewDeckButton;
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Header;
	import feathers.controls.Icon;
	import feathers.controls.Label;
	import feathers.controls.LayoutGroup;
	import feathers.controls.List;
	import feathers.controls.Panel;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.controls.text.ITextEditorViewPort;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextEditorViewPort;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.layout.VerticalLayout;
	import feathers.textures.Scale9Textures;
	import feathers.themes.StyleNameFunctionTheme;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import mx.core.FontAsset;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import feathers.system.DeviceCapabilities;
	import starling.display.Quad;
	import feathers.controls.TextArea;
	
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
		
		[Embed(source = "../../../../lib/fonts/F-ck Beans.ttf",
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
		
		[Embed(source = "../../../../lib/fonts/SimplonMono-Regular.ttf",
		fontName = "SimplonMono", 
		mimeType = "application/x-font-truetype", 
		advancedAntiAliasing="true",
		embedAsCFF="false")]
		public static var SimplonMono:Class;
		
		[Embed(source = "../../../../lib/fonts/SimplonNorm-Light.ttf",
		fontName = "SimplonNorm", 
		mimeType = "application/x-font-truetype", 
		advancedAntiAliasing="true",
		embedAsCFF="false")]
		public static var SimplonNorm:Class;
		
		[Embed(source = "../../../../lib/fonts/SupriaSans-Light.ttf",
		fontName = "SupriaSans", 
		mimeType = "application/x-font-truetype", 
		advancedAntiAliasing="true",
		embedAsCFF="false")]
		public static var SupriaSans:Class;
		
		[Embed(source = "../../../../lib/fonts/SupriaSans-Medium.ttf",
		fontName = "SupriaSans", 
		fontWeight= "bold",
		mimeType = "application/x-font-truetype", 
		advancedAntiAliasing="true",
		embedAsCFF="false")]
		public static var SupriaSansBold:Class;
		
		/**
		 * The name of the embedded font used by controls in this theme. Comes
		 * in normal and bold weights.
		 */
		public static const FONT_NAME:String = "SourceSansPro";

		protected static const PRIMARY_BACKGROUND_COLOR:uint = 0x4a4137;
		protected static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
		protected static const DARK_TEXT_COLOR:uint = 0x1a1816;
		protected static const SELECTED_TEXT_COLOR:uint = 0xff9900;
		protected static const DISABLED_TEXT_COLOR:uint = 0x8a8a8a;
		protected static const DARK_DISABLED_TEXT_COLOR:uint = 0x383430;
		protected static const LIST_BACKGROUND_COLOR:uint = 0x383430;
		protected static const TAB_BACKGROUND_COLOR:uint = 0x1a1816;
		protected static const TAB_DISABLED_BACKGROUND_COLOR:uint = 0x292624;
		protected static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint = 0x2e2a26;
		protected static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint = 0x2e2a26;
		protected static const MODAL_OVERLAY_COLOR:uint = 0x29241e;
		protected static const MODAL_OVERLAY_ALPHA:Number = 0.8;
		protected static const DRAWER_OVERLAY_COLOR:uint = 0x29241e;
		protected static const DRAWER_OVERLAY_ALPHA:Number = 0.4;
		protected static const VIDEO_OVERLAY_COLOR:uint = 0x1a1816;
		protected static const VIDEO_OVERLAY_ALPHA:Number = 0.2;
		
		protected static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);
		protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 50, 50);
		protected static const BUTTON_SELECTED_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 44, 44);
		protected static const BACK_BUTTON_SCALE3_REGION1:Number = 24;
		protected static const BACK_BUTTON_SCALE3_REGION2:Number = 6;
		protected static const FORWARD_BUTTON_SCALE3_REGION1:Number = 6;
		protected static const FORWARD_BUTTON_SCALE3_REGION2:Number = 6;
		protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(3, 0, 2, 82);
		protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
		protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 3, 75);
		protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);
		protected static const TAB_SCALE9_GRID:Rectangle = new Rectangle(19, 19, 50, 50);
		protected static const SPINNER_LIST_SELECTION_OVERLAY_SCALE9_GRID:Rectangle = new Rectangle(3, 9, 1, 70);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 5;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 14;
		
		/**
		 * The screen density of an iPhone with Retina display. The textures
		 * used by this theme are designed for this density and scale for other
		 * densities.
		 */
		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;

		/**
		 * The screen density of an iPad with Retina display. The textures used
		 * by this theme are designed for this density and scale for other
		 * densities.
		 */
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;
		
		
		
		private var atlas:TextureAtlas; 
		
		
	
		/**
		 * @private
		 */
		protected var _originalDPI:int;

		/**
		 * The original screen density used for scaling.
		 */
		public function get originalDPI():int
		{
			return this._originalDPI;
		}

		/**
		 * @private
		 */
		protected var _scaleToDPI:Boolean;

		/**
		 * Indicates if the theme scales skins to match the screen density of
		 * the device.
		 */
		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}

		/**
		 * Skins are scaled by a value based on the screen density on the
		 * content scale factor.
		 */
		protected var scale:Number = 1;
		
		/**
		 * StageText scales strangely when contentsScaleFactor > 1, so we need
		 * to account for that.
		 */
		protected var stageTextScale:Number = 1;
		
		/**
		 * The size, in pixels, of minor regions in the grid. Used for larger
		 * padding and gaps.
		 */
		protected var gutterSize:int;

		/**
		 * The size, in pixels, of smaller padding and gaps within the major
		 * regions in the grid.
		 */
		protected var smallGutterSize:int;
		
		/**
		 * The size, in pixels, of smaller UI controls.
		 */
		protected var smallControlSize:int;

		protected var popUpFillSize:int;
		protected var calloutBackgroundMinSize:int;
		protected var scrollBarGutterSize:int;

		
		private var levelIconTexture:Scale9Textures;
		private var selectModeBackgroundTexture:Scale9Textures;
		
		/**
		 * Constructor.
		 *
		 * @param scaleToDPI Determines if the theme's skins will be scaled based on the screen density and content scale factor.
		 */
		public function LastArgumentTheme(scaleToDPI:Boolean = true) 
		{
			this._scaleToDPI = scaleToDPI;
			this.createTextureAtlas();
			this.initialize();
		}
		
		private function initialize():void
        {
			//var font:Font = new FontAsset.FontAfterDisaster();
			initializeScale();
			initializeGlobals();
			initializeDimensions();
			initializeTextures();
			initializeFormats();
			initializeStyleProviders ();
        }
		
		/**
		 * Initializes the scale value based on the screen density and content
		 * scale factor.
		 */
		protected function initializeScale():void
		{
			var starling:Starling = Starling.current;
			var nativeScaleFactor:Number = 1;
			if(starling.supportHighResolutions) 
			{
				nativeScaleFactor = starling.nativeStage.contentsScaleFactor; 
			}
			var scaledDPI:int = DeviceCapabilities.dpi / (starling.contentScaleFactor / nativeScaleFactor);
			this._originalDPI = scaledDPI;
			if(this._scaleToDPI)
			{
				if(DeviceCapabilities.isTablet(starling.nativeStage))
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			this.scale = scaledDPI / this._originalDPI;
			this.stageTextScale = this.scale / nativeScaleFactor;
		}
		
		/**
		 * Initializes common values used for setting the dimensions of components.
		 */
		protected function initializeDimensions():void
		{
			//this.gridSize = Math.round(88 * this.scale);
			this.smallGutterSize = Math.round(11 * this.scale);
			this.gutterSize = Math.round(22 * this.scale);
			//this.controlSize = Math.round(58 * this.scale);
			//this.smallControlSize = Math.round(22 * this.scale);
			this.popUpFillSize = Math.round(800 * this.scale);
			//this.calloutBackgroundMinSize = Math.round(11 * this.scale);
			//this.scrollBarGutterSize = Math.round(4 * this.scale);
			//this.wideControlSize = this.gridSize * 3 + this.gutterSize * 2;
		}
		
		private function initializeTextures() :void {
		
	
			levelIconTexture = new Scale9Textures(this.atlas.getTexture( "level" ), new Rectangle(0,0, 94, 27));
			
			selectModeBackgroundTexture = new Scale9Textures(this.atlas.getTexture( "modeBG" ), new Rectangle(0,0,220,280))
		}
		
		private function initializeFormats () :void {
			}
		
		private function initializeStyleProviders():void
		{
			//
			this.getStyleProviderForClass( Icon ).setFunctionForStyleName('levelIcon', this.setLevelIconStyles); 
			this.getStyleProviderForClass( Icon ).setFunctionForStyleName('lobbyLevelIcon', this.setLobbyLevelIconStyles); 
			
			// button
			this.getStyleProviderForClass( Button ).setFunctionForStyleName('mainButton', this.setMainButtonStyles);
			this.getStyleProviderForClass( Button ).setFunctionForStyleName('closeView', this.seCloseViewButtonStyles );	
			this.getStyleProviderForClass( Button ).setFunctionForStyleName('smallButton', this.setSmallButtonStyles );	
		
			// alert
			this.getStyleProviderForClass(Alert).defaultStyleFunction = this.setAlertStyles;
			this.getStyleProviderForClass(ButtonGroup).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_BUTTON_GROUP, this.setAlertButtonGroupStyles);
			this.getStyleProviderForClass(Header).setFunctionForStyleName(Alert.DEFAULT_CHILD_STYLE_NAME_HEADER, this.setAlertHeaderStyles);

			// lobby
			this.getStyleProviderForClass( Header).setFunctionForStyleName('lobbyHeader', this.setLobbyHeaderStyles);
			this.getStyleProviderForClass(List).setFunctionForStyleName("lobbyPlayersList", this.setLobbyPlayersListStyles);	
			this.getStyleProviderForClass(List).setFunctionForStyleName("lobbyInvitesList", this.setLobbyInvitesListStyles);
			this.getStyleProviderForClass(List).setFunctionForStyleName("lobbyRequestsList", this.setLobbyRequestsListStyles);
			this.getStyleProviderForClass(Label).setFunctionForStyleName("lobbyNicknameLabel", this.setLobbyNicknameLabelStyles);
			this.getStyleProviderForClass(Label).setFunctionForStyleName("lobbyLevelLabel", this.setLobbyLevelLabelStyles);
			this.getStyleProviderForClass(Label).setFunctionForStyleName("lobbyModeLabel", this.setLobbyModeLabelStyles);
			this.getStyleProviderForClass(Label).setFunctionForStyleName("lobbyModePopupLabel", this.setLobbyModePopupLabelStyles);
			this.getStyleProviderForClass( Label ).setFunctionForStyleName('lobbyFunctionLabel', this.setLobbyFunctionLabelStyles);
			this.getStyleProviderForClass(Panel).setFunctionForStyleName('modePopupPanel', this.setPopupModePanelStyles);

			this.getStyleProviderForClass(LayoutGroup).setFunctionForStyleName('modeBlock', this.setModeBlockStyles);
			
			this.getStyleProviderForClass( TextArea ).defaultStyleFunction = setTextAreaStyles;
			
		} 
		
		private function setTextAreaStyles (textArea:TextArea) :void {
			textArea.textEditorFactory = function():ITextEditorViewPort
			{
				var editor:TextFieldTextEditorViewPort = new TextFieldTextEditorViewPort();
				editor.textFormat = new TextFormat("SupriaSans", 12, 0);  ;
				editor.embedFonts = true;
				return editor; 
			}
			//textArea.textEditorProperties.textFormat = new TextFormat("SupriaSans", 
			//12, 0); 
		}
			
		private function setLobbyButtonStyles( button:Button ):void
		{
			button.defaultLabelProperties.embedFonts = true; 
			button.defaultLabelProperties.textFormat = new TextFormat("SupriaSans", 
			12, 0x113f18, true); 
		}
		
		private function setModeBlockStyles (group:LayoutGroup) :void {
			group.backgroundSkin = new Quad(1, 1, 0xFFFFFF);
			group.width = 220;
			group.height = 280;
			
			//group.backgroundSkin = new Scale9Image(selectModeBackgroundTexture, 1);
			var layout:VerticalLayout = new VerticalLayout();
			layout.firstGap = 10;
			layout.gap = 0;
			layout.paddingTop = 20;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			group.layout = layout;
		}
			
		private function setLevelIconStyles (icon:Icon) :void {
			icon.source = new Scale9Image (levelIconTexture, 1);
		}
		
		private function setLobbyLevelIconStyles (icon:Icon) :void {
			icon.source = new Scale9Image (levelIconTexture, 0.4);
		}
		
		private function setLobbyFunctionLabelStyles (label:Label) :void {
			label.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat("SupriaSans", 12, 0x113f18, true); 
				textRenderer.antiAliasType = AntiAliasType.ADVANCED;
				textRenderer.embedFonts = true;
				return textRenderer;
			}
		}
		private function setLobbyNicknameLabelStyles (label:Label) :void {
			label.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat("SupriaSans", 11, 0, true); 
				textRenderer.antiAliasType = AntiAliasType.ADVANCED;
				textRenderer.embedFonts = true;
				return textRenderer;
			}
		}
			
		private function setLobbyModeLabelStyles (label:Label) :void {
			label.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat("SupriaSans", 11, 0, true); 
				textRenderer.antiAliasType = AntiAliasType.ADVANCED;
				textRenderer.textFormat.align = TextFormatAlign.CENTER;
				textRenderer.embedFonts = true;
				return textRenderer;
			}
		}
		
		private function setLobbyModePopupLabelStyles (label:Label) :void {
			label.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat("CasualHardcore", 18, 0x222222); 
				textRenderer.antiAliasType = AntiAliasType.ADVANCED;
				textRenderer.textFormat.align = TextFormatAlign.CENTER;
				textRenderer.embedFonts = true;
				return textRenderer;
			}
		}
		
		private function setLobbyLevelLabelStyles (label:Label) :void {
			label.textRendererFactory = function():ITextRenderer
			{
				var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
				textRenderer.textFormat = new TextFormat("SupriaSans", 14, 0, true); 
				textRenderer.textFormat.align == TextFormatAlign.CENTER;
				textRenderer.antiAliasType = AntiAliasType.ADVANCED;
				textRenderer.embedFonts = true;
				return textRenderer;
			}
		}
		
		protected function setLobbyPlayersListStyles (list:List) :void {
			
			const lobbyPlayersLayout:VerticalLayout = new VerticalLayout();
			lobbyPlayersLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			lobbyPlayersLayout.gap = 2;
			lobbyPlayersLayout.hasVariableItemDimensions = true;

			list.layout = lobbyPlayersLayout;
			list.itemRendererFactory = lobbyPlayersListRendererFactory;
			list.autoHideBackground = true;
		}
		
		protected function lobbyPlayersListRendererFactory () :IListItemRenderer {
			var renderer:IListItemRenderer = new LobbyPlayersListRenderer();
			renderer.width = 310;
			renderer.height = 36;
			return renderer;
		}
		
		protected function setLobbyInvitesListStyles (list:List) :void {
			
			const lobbyInvitesLayout:VerticalLayout = new VerticalLayout();
			lobbyInvitesLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			lobbyInvitesLayout.gap = 2;
			lobbyInvitesLayout.hasVariableItemDimensions = true;

			list.layout = lobbyInvitesLayout;
			list.itemRendererFactory = lobbyInvitesListRendererFactory;
			list.autoHideBackground = true;
		}
		
		protected function lobbyInvitesListRendererFactory () :IListItemRenderer {
			var renderer:IListItemRenderer = new LobbyInvitesListRenderer('accept');
			renderer.width = 370;
			renderer.height = 36;
			return renderer;
		}
		
		protected function setLobbyRequestsListStyles (list:List) :void {
			
			const lobbyRequestsLayout:VerticalLayout = new VerticalLayout();
			lobbyRequestsLayout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			lobbyRequestsLayout.gap = 2;
			lobbyRequestsLayout.hasVariableItemDimensions = true;

			list.layout = lobbyRequestsLayout;
			list.itemRendererFactory = lobbyRequestsListRendererFactory;
			list.autoHideBackground = true;
		}
		
		protected function lobbyRequestsListRendererFactory () :IListItemRenderer {
			var renderer:IListItemRenderer = new LobbyInvitesListRenderer('cancel');
			renderer.width = 370;
			renderer.height = 36;
			return renderer;
		}
		
		protected function setPopupModePanelStyles (panel:Panel) :void {
			panel.backgroundSkin = new Quad(1, 1, 0x222222);;
			panel.padding = 40;
			panel.paddingTop = 50;
			panel.paddingBottom = 40;
		}
		
		protected function setAlertStyles(alert:Alert):void
		{
			//this.setScrollerStyles(alert);
			
			alert.backgroundSkin = new Quad(1,1,0x222222);

			alert.padding = 60;
			alert.paddingBottom = 30;
			alert.gap = 20;
			
			var itf:TextFormat = new TextFormat("SupriaSans", 16,0xFFFFFF);//);
			itf.align = "center";
			 
			alert.messageProperties.textFormat = itf;
			alert.messageProperties.wordWrap = true;
			alert.messageProperties.embedFonts = true;
			//alert.maxWidth = this.popUpFillSize;
			//alert.maxHeight = this.popUpFillSize;
		}
		
		private function setAlertHeaderStyles (header:Header) :void {
			header.paddingTop = 20;
			header.titleProperties.embedFonts = true; 
			header.titleProperties.textFormat = new TextFormat("SupriaSans", 
			12, 0xd1d548); 
		}
		
		private function setLobbyHeaderStyles (header:Header) :void {
			header.paddingTop = 8;
			header.paddingLeft = 10;
			header.paddingBottom = 7;
			header.titleAlign = Header.TITLE_ALIGN_PREFER_LEFT;
			header.backgroundSkin = new Quad(1,1, 0xFFCC00);
			header.titleProperties.embedFonts = true; 
			header.titleProperties.textFormat = new TextFormat("SupriaSans", 
			12, 0); 
			//header.titleProperties.textFormat.bold = true;
		}
				
		protected function setAlertButtonGroupStyles(group:ButtonGroup):void
		{
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
			group.distributeButtonSizes = false;
			group.gap = 30;
			group.padding = 20;
			group.customButtonStyleName = "smallButton";
		}
		
		private function createTextureAtlas():void
		{
			var atlasTexture:Texture = Texture.fromEmbeddedAsset( ATLAS_BITMAP ); 
			var atlasXML:XML = XML( new ATLAS_XML() );
			this.atlas = new TextureAtlas( atlasTexture, atlasXML );
		}
		
		private function setMainButtonStyles( button:Button ):void
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
			button.hoverLabelProperties.textFormat = new TextFormat("CasualHardcore", 
			24, 0x222222); 
		}
		
		private function seCloseViewButtonStyles (button:Button) :void {
			button.defaultIcon = new Scale9Image( 
			new Scale9Textures(this.atlas.getTexture( "closeBtnDefault" ), new Rectangle(0,0,10,10))) as DisplayObject;
			button.downIcon = new Scale9Image( 
			new Scale9Textures(this.atlas.getTexture( "closeBtnDown" ), new Rectangle(0,0,10,10))) as DisplayObject;
			button.hoverIcon = button.downIcon;
			button.iconOffsetX = 40;
			button.iconOffsetY = 2;
			button.defaultLabelProperties.embedFonts = true; 
			button.defaultLabelProperties.textFormat = new TextFormat("SupriaSans", 
			12, 0xffffff); 
			button.hoverLabelProperties.embedFonts = true;
			button.downLabelProperties.textFormat = 
			button.hoverLabelProperties.textFormat = new TextFormat("SupriaSans", 
			12, 0xff0000); 
		}
		private function setSmallButtonStyles (button:Button) :void {
			button.defaultSkin = new Scale9Image( 
			new Scale9Textures(this.atlas.getTexture( "btnDefaultSmall" ), new Rectangle(0,5,120,30))) as DisplayObject;
			button.downSkin = new Scale9Image( 
			new Scale9Textures(this.atlas.getTexture( "btnDownSmall" ), new Rectangle(0,5,120,30))) as DisplayObject;
			button.hoverSkin = button.downSkin;
						
			button.defaultLabelProperties.embedFonts = true; 
			button.defaultLabelProperties.textFormat = new TextFormat("CasualHardcore", 
			18, 0xffffff); 
			button.hoverLabelProperties.embedFonts = true;
			button.downLabelProperties.textFormat = 
			button.hoverLabelProperties.textFormat = new TextFormat("CasualHardcore", 
			18, 0x222222); 
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