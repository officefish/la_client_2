package com.sla.theme 
{
	import com.demonsters.debugger.MonsterDebugger;
	import feathers.controls.Button;
	import feathers.controls.Icon;
	import feathers.controls.Label;
	import feathers.controls.renderers.LayoutGroupListItemRenderer;
	import feathers.display.Scale9Image;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LobbyPlayersListRenderer extends LayoutGroupListItemRenderer
	{
		
		private var background:Quad;
		private var nicknameLabel:Label;
		private var levelLabel:Label;
		private var thumbnail:Scale9Image;
		private var levelIcon:Icon;
		private var functionLabel:Label;
		
		private static const THUMBNAIL_X:uint = 8;
		private static const THUMBNAIL_Y:uint = 3;
		private static const NICKNAME_LABEL_X:uint = 95;
		private static const NICKNAME_LABEL_Y:uint = 11;
		private static const LEVEL_LABEL_X:uint = 62;
		private static const LEVEL_LABEL_Y:uint = 5;
		private static const LABEL_PADDING:uint = 0;
		
		private static const INVITE_RIGHT:uint = 25;
		private static const INVITE_TOP:uint = 10;
		
		private static const DEFAULT_BG_COLOR:uint = 0xD3D3D3;
		private static const HOVER_BG_COLOR:uint = 0xFFFFFF;
		
		public function LobbyPlayersListRenderer() 
		{
					
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
		
		private var _player:Boolean;
		private function set player (value:Boolean) :void {
			_player = value;
			if (_player == false) {
				background.color = DEFAULT_BG_COLOR;
				addChild(functionLabel);
				this.addEventListener(TouchEvent.TOUCH, onTouch); 
			} else {
				if (contains(functionLabel)) {
					removeChild(functionLabel);
				}
				background.color = 0xAAAAAA;
				if (this.hasEventListener(TouchEvent.TOUCH)) {
					this.removeEventListener(TouchEvent.TOUCH, onTouch);
				}
			}
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
			
		override protected function initialize():void
		{
			this.layout = new AnchorLayout();
			
			background = new Quad (this.width, this.height, DEFAULT_BG_COLOR);
			this.addChild(background);
			
			nicknameLabel = new Label();
			nicknameLabel.styleNameList.add("lobbyNicknameLabel");
			nicknameLabel.layoutData = LobbyPlayersListRenderer.nicknameLayout;
			this.addChild(nicknameLabel);
			
			levelLabel = new Label();
			levelLabel.styleNameList.add("lobbyLevelLabel");
			levelLabel.layoutData = LobbyPlayersListRenderer.levelLayout;
			this.addChild(levelLabel);
						
			levelIcon = new Icon();
			levelIcon.x = 47;
			levelIcon.y = 20;
			levelIcon.styleNameList.add('lobbyLevelIcon');
			addChild(levelIcon);
			
			functionLabel = new Label();
			functionLabel.text = 'invite'; 
			functionLabel.styleNameList.add('lobbyFunctionLabel');
			functionLabel.layoutData = LobbyPlayersListRenderer.functionLayout;
			addChild(functionLabel);
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
		
		override protected function commitData():void
        {
            if(this._data && this._owner)
            {
                this.uid = this._data.uid;
				this.nicknameLabel.text = 'player' + this._data.id;
				this.levelLabel.text = this._data.level;
				
				var texture:Texture = Assets.getHeroAssetById(this.uid);
				this.thumbnail = new Scale9Image(new Scale9Textures(texture, new Rectangle(0,0,50,50)), 0.25);
				this.thumbnail.x = THUMBNAIL_X;
				this.thumbnail.y = THUMBNAIL_Y;
				addChild(this.thumbnail);
				
				this.player = this._data.player;
				
			}
            else
            {
                this.nicknameLabel.text = null;
				this.levelLabel.text = null;
				this.player = false;
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
		
		
		
	}

}