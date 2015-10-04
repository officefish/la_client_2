package com.sla.theme 
{
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.controls.Button;
	import feathers.controls.Icon;
	import feathers.display.Scale9Image;
	import feathers.controls.Label;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import starling.display.Quad;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LobbyInvitesListRenderer extends LayoutGroupListItemRenderer 
	{
		private var background:Quad;
		private var nicknameLabel:Label;
		private var levelLabel:Label;
		private var thumbnail:Scale9Image;
		private var levelIcon:Icon;
		private var functionLabel:Label;
		private var modeLabel:Label;
		
		private static const THUMBNAIL_X:uint = 8;
		private static const THUMBNAIL_Y:uint = 3;
		private static const NICKNAME_LABEL_X:uint = 95;
		private static const NICKNAME_LABEL_Y:uint = 11;
		private static const LEVEL_LABEL_X:uint = 62;
		private static const LEVEL_LABEL_Y:uint = 5;
		private static const LABEL_PADDING:uint = 0;
		
		private static const INVITE_RIGHT:uint = 25;
		private static const INVITE_TOP:uint = 10;
		
		private static const MODE_RIGHT:uint = 80;
		private static const MODE_TOP:uint = 11;
		
		private static const DEFAULT_BG_COLOR:uint = 0xD3D3D3;
		private static const HOVER_BG_COLOR:uint = 0xFFFFFF;
		
		private var functionLabelText:String;
		
		public function LobbyInvitesListRenderer(label:String) 
		{
			this.functionLabelText = label;
			super();
		}
		
		private var _uid:int;
		private function set uid (value:int) :void {
			_uid = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		private function get uid () :int {
			return _uid;
		}
		
		private var _id:int;
		private function set id (value:int) :void {
			_id = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		private function get id () :int {
			return _id;
		}
		
	
		private var _mode:int;
		private function set mode (value:int) :void {
			_mode = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		private function get mode () :int {
			return _mode;
		}
		
		
		override protected function initialize():void
		{
			this.layout = new AnchorLayout(); 
			
			background = new Quad (this.width, this.height, DEFAULT_BG_COLOR);
			this.addChild(background);
			
			nicknameLabel = new Label();
			nicknameLabel.styleNameList.add("lobbyNicknameLabel");
			nicknameLabel.layoutData = LobbyInvitesListRenderer.nicknameLayout;
			this.addChild(nicknameLabel);
			
			levelLabel = new Label();
			levelLabel.styleNameList.add("lobbyLevelLabel");
			levelLabel.layoutData = LobbyInvitesListRenderer.levelLayout;
			this.addChild(levelLabel);
			
			modeLabel = new Label();
			modeLabel.styleNameList.add('lobbyModeLabel');
			modeLabel.layoutData = LobbyInvitesListRenderer.modeLayout;
			addChild(modeLabel);
						
			levelIcon = new Icon();
			levelIcon.x = 47;
			levelIcon.y = 20;
			levelIcon.styleNameList.add('lobbyLevelIcon');
			addChild(levelIcon);
			
			functionLabel = new Label();
			functionLabel.text = functionLabelText; 
			functionLabel.styleNameList.add('lobbyFunctionLabel');
			functionLabel.layoutData = LobbyInvitesListRenderer.functionLayout;
			addChild(functionLabel);
				
		}
		
		override protected function commitData():void
        {
            if(this._data && this._owner)
            {
                this.uid = this._data.uid;
				this.nicknameLabel.text = 'player' + this._data.id;
				this.levelLabel.text = this._data.level;
				this.modeLabel.text = this.getModeDescription(this._data.mode);
				this.mode = this._data.mode;
				
				var texture:Texture = Assets.getHeroAssetById(this.uid); 
				this.thumbnail = new Scale9Image(new Scale9Textures(texture, new Rectangle(0,0,50,50)), 0.25);
				this.thumbnail.x = THUMBNAIL_X;
				this.thumbnail.y = THUMBNAIL_Y;
				addChild(this.thumbnail);
				
			}
            else
            {
                this.nicknameLabel.text = null;
				this.levelLabel.text = null;
            }
			
			this.addEventListener(TouchEvent.TOUCH, onTouch); 
			
		}
		
		private function getModeDescription (value:int) :String {
			var str:String;
			switch(value) {
				case 0: {
					str = '(sprint)';
					break;
				}
				case 1: {
					str = '(regular)';
					break;
				}
				case 2: {
					str = '(control)';
					break;
				}
			}
			return str;
		}
		
		private function onTouch (event:TouchEvent) :void {
			if (event.getTouch(this, TouchPhase.HOVER)) {
				background.color = HOVER_BG_COLOR;
			} else {
				background.color = DEFAULT_BG_COLOR;
			}
			if (event.getTouch(this, TouchPhase.BEGAN))
			{
				background.color = HOVER_BG_COLOR;
				this.isSelected = true;
			}
			if (event.getTouch(this, TouchPhase.ENDED))
			{
				background.color = HOVER_BG_COLOR; 
			}
		}
		
		private static var _nicknameLayoutData:AnchorLayoutData;
		private static function get nicknameLayout () :AnchorLayoutData {
			if (_nicknameLayoutData == null) {
				_nicknameLayoutData = new AnchorLayoutData();
				_nicknameLayoutData.top = NICKNAME_LABEL_Y;
				_nicknameLayoutData.right = LABEL_PADDING;
				_nicknameLayoutData.bottom = LABEL_PADDING;
				_nicknameLayoutData.left = NICKNAME_LABEL_X;
			}
			return _nicknameLayoutData;
		}
		private static var _levelLayoutData:AnchorLayoutData;
		private static function get levelLayout () :AnchorLayoutData {
			if (_levelLayoutData == null) {
				_levelLayoutData = new AnchorLayoutData();
				_levelLayoutData.top = LEVEL_LABEL_Y;
				_levelLayoutData.right = LABEL_PADDING;
				_levelLayoutData.bottom = LABEL_PADDING;
				_levelLayoutData.left = LEVEL_LABEL_X;
			}
			return _levelLayoutData;
		}
		
		private static var _functionLabelLayoutData:AnchorLayoutData;
		private static function get functionLayout () :AnchorLayoutData {
			if (_functionLabelLayoutData == null) {
				_functionLabelLayoutData = new AnchorLayoutData();
				_functionLabelLayoutData.top = INVITE_TOP;
				_functionLabelLayoutData.right = INVITE_RIGHT;
			}
			return _functionLabelLayoutData; 
		}
		
		private static var _modeLabelLayoutData:AnchorLayoutData;
		private static function get modeLayout () :AnchorLayoutData {
			if (_modeLabelLayoutData == null) {
				_modeLabelLayoutData = new AnchorLayoutData();
				_modeLabelLayoutData.top = MODE_TOP;
				_modeLabelLayoutData.right = MODE_RIGHT;
			}
			return _modeLabelLayoutData; 
		}
		
	}

}