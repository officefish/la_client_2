package com.sla.mvc.view.lobby 
{
	import com.transform.Transform;
	import flash.display.Bitmap;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
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
		
		private var playersStack:PlayersStack;
		private var inviteStack:InvitesStack;
		private var suggestionStack:InvitesStack;
		
		[Embed(source="../../../../../../lib/assets/efflam-mercier-speedpainting-final.jpg")]
		private var Background:Class;
		private var backrgound:Image;
		
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
			addChild(playersStack);
			
			inviteStack = new InvitesStack('Invites for you', 380, 240, 'lobbyInvitesList');
			addChild(inviteStack);

			suggestionStack = new InvitesStack('You Invite', 380, 240, 'lobbyRequestsList');
			addChild(suggestionStack);
			
			var shiftX:int = (stageWidth - 705) / 2;
			var shiftY:int = (stageHeight - 485) / 2;
			shiftX += 100;
						
			playersStack.x = shiftX;
			inviteStack.x = suggestionStack.x = playersStack.x + 325;
			playersStack.y = inviteStack.y = shiftY;
			suggestionStack.y = playersStack.y + 245;
			
			_initFlag = true;
		}
		
		public function initPlayers (list:Array) :void {
			playersStack.initDataProvider(list);
		}
		
		public function addUser (user:Object) :void {
			playersStack.addUser(user);
		}
		
		public function removeUser(userId:int) :void {
			playersStack.removeUser(userId);
		}
		
	}

}