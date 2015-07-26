package com.sla.mvc.view.lobby 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.la.mvc.view.collection.NewDeckButton;
	import com.sla.event.starling.StarlingLobbyEvent;
	import com.transform.Transform;
	import feathers.controls.Button;
	import feathers.controls.Panel;
	import feathers.core.PopUpManager;
	import feathers.layout.AnchorLayoutData;
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.filters.FragmentFilter;
	import starling.textures.Texture;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class Lobby extends Sprite 
	{
		
		private var _initFlag:Boolean = false;
		private var stageWidth:int;
		private var stageHeight:int;
		
		private var closeButton:Button;
		private var closeQuad:Quad;
		
		private var playersStack:PlayersStack;
		private var inviteStack:InvitesStack;
		private var suggestionStack:InvitesStack;
		
		[Embed(source="../../../../../../lib/assets/efflam-mercier-speedpainting-final.jpg")]
		private var Background:Class;
		private var backrgound:Image;
		
		private var panel:Panel;
		
		private var inviteData:Object;
		
		public function Lobby() 
		{
			addEventListener (Event.ADDED_TO_STAGE, onAddedToStage);		
		}
		
		private function onAddedToStage (event:Event) :void {
			if (!_initFlag) {
				init();
			}
		}
		
		public function resize (stageWidth:int, stageHeight:int) :void {
			this.stageWidth = stageWidth;
			this.stageHeight = stageHeight;
		}
		
		private function init () :void {
			var backgroundBitmap:Bitmap = new Background() as Bitmap;
			backgroundBitmap = Transform.toSize (backgroundBitmap, stageWidth, stageHeight);
			var backgroundTexture:Texture = Texture.fromBitmap(backgroundBitmap, false) 
			backrgound = new Image(backgroundTexture);
			this.addChild(backrgound); 
			
			playersStack = new PlayersStack("Players", 320, 485);
			playersStack.addEventListener(StarlingLobbyEvent.INVITE, onInvite);
			addChild(playersStack);
			
			inviteStack = new InvitesStack('Invites for you', 380, 240, 'lobbyInvitesList', StarlingLobbyEvent.ACCEPT);
			inviteStack.addEventListener(StarlingLobbyEvent.ACCEPT, onAcceptInvite);
			addChild(inviteStack);

			suggestionStack = new InvitesStack('You Invited', 380, 240, 'lobbyRequestsList', StarlingLobbyEvent.CANCEL);
			suggestionStack.addEventListener(StarlingLobbyEvent.CANCEL, onCancelInvite);
			addChild(suggestionStack);
			
			var shiftX:int = (stageWidth - 705) / 2;
			var shiftY:int = (stageHeight - 485) / 2;
			shiftX += 100;
						
			playersStack.x = shiftX;
			inviteStack.x = suggestionStack.x = playersStack.x + 325;
			playersStack.y = inviteStack.y = shiftY;
			suggestionStack.y = playersStack.y + 245;
			
			var closeButton:Button = new Button();
			closeButton.label = 'close';
			closeButton.styleNameList.add('closeView');
			//var cbLayoutData:AnchorLayoutData = new AnchorLayoutData();
			//cbLayoutData.right = 20;
			//cbLayoutData.top = 2;
			//closeButton.layoutData = cbLayoutData;
			closeButton.addEventListener( Event.TRIGGERED, onClose);
			
			var closeQuad:Quad = new Quad(60, 25, 0);
			closeQuad.alpha = 0.5;
			addChild(closeQuad);
			
			closeQuad.x = inviteStack.x + inviteStack.width - closeQuad.width;
			closeQuad.y = inviteStack.y - closeQuad.height - 2;
			
			closeButton.x = closeQuad.x;
			closeButton.y = closeQuad.y + 4;
			addChild(closeButton);
			
			ModePopup.init(onModeSelect);
			
			_initFlag = true;
		}
		
		private function onModeSelect(mode:int) :void {
			//MonsterDebugger.log ('selected mode: ' + mode);
			deactivateAlertFilters();
			inviteData.mode = mode;
			dispatchEvent(new StarlingLobbyEvent(StarlingLobbyEvent.INVITE, true, inviteData));
		}
		
		private function onClose (event:Event) :void {
			dispatchEvent(new StarlingLobbyEvent(StarlingLobbyEvent.CLOSE, true, event.data));
		}
		
		private function onInvite(event:StarlingLobbyEvent) :void {
			inviteData = event.data;
			ModePopup.show();
			activateAlertFilters();
			
		}
		
		private function onCancelInvite(event:StarlingLobbyEvent) :void {
			dispatchEvent(new StarlingLobbyEvent(StarlingLobbyEvent.CANCEL, true, event.data));
		}
		
		private function onAcceptInvite(event:StarlingLobbyEvent) :void {
			dispatchEvent(new StarlingLobbyEvent(StarlingLobbyEvent.ACCEPT, true, event.data));
		}
		
		public function initPlayers (list:Array) :void {
			playersStack.initDataProvider(list);
		}
		
		public function addUser (user:Object) :void {
			playersStack.addUser(user);
		}
		
		public function invite(user:Object) :void {
			inviteStack.addUser(user);
		}
		
		public function confirmInvite(user:Object) :void {
			suggestionStack.addUser(user);
			playersStack.blockUser(user.id);
		}
		
		public function removeUser(userId:int) :void {
			playersStack.removeUser(userId);
			inviteStack.removeUser(userId);
			suggestionStack.removeUser(userId);
		}
		
		public function cancelInvite(userId:int) :void {
			inviteStack.removeUser(userId);
		}
		
		public function confirmCancelInvite(userId:int) :void {
			suggestionStack.removeUser(userId);
		}
		
		public function clear () :void {
			playersStack.clear();
			inviteStack.clear();
			suggestionStack.clear();
		}
		
		private function activateAlertFilters () :void {
			this.filter = Lobby.blurFilter;
			playersStack.filter = Lobby.darkenFilter;
			inviteStack.filter = Lobby.darkenFilter;
			suggestionStack.filter = Lobby.darkenFilter;
			backrgound.filter = Lobby.darkenFilter;
		}
		private function deactivateAlertFilters () :void {
			this.filter = null;
			playersStack.filter = null;
			inviteStack.filter = null;
			suggestionStack.filter = null;
			backrgound.filter = null;
		}
		
		private static var _blurFilter:BlurFilter;
		private static function get blurFilter () :FragmentFilter {
			if (_blurFilter == null) {
				_blurFilter = new BlurFilter();
			}
			return _blurFilter; 
		}
		private static var _darkenFilter:ColorMatrixFilter;
		private static function get darkenFilter () :FragmentFilter {
			if (_darkenFilter == null) {
				_darkenFilter = new ColorMatrixFilter();
				_darkenFilter.adjustBrightness(-0.40);
			}
			return _darkenFilter;
		}
	}

}