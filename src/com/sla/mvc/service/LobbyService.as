package com.sla.mvc.service 
{
	import com.la.socket.IWebSocketWrapper;
	import com.la.socket.SocketFactory;
	import com.sla.event.LobbyServiceEvent;
	import com.worlize.websocket.WebSocketError;
	import com.worlize.websocket.WebSocketErrorEvent;
	import com.worlize.websocket.WebSocketEvent;
	import com.worlize.websocket.WebSocketMessage;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LobbyService extends Actor 
	{
		
		private var wrapper:IWebSocketWrapper;
        private var userId:uint;
        private var heroId:int;
        private var level:int;
        private var hero_uid:int;
        private var deck_id:int; 
		
		private static const USER_JOIN:String = 'user_join';
        private static const INIT_PLAYERS:String = 'init_players';
        private static const USER_LEAVE:String = 'user_leave';
        private static const INVITE:String = 'invite';
        private static const CONFIRM_INVITE:String = 'confirm_invite';
        private static const CANCEL_INVITE:String = 'cancel_invite';
        private static const CONFIRM_CANCEL:String = 'confirm_cancel';
        private static const REJECT_INVITE:String = 'reject_invite';
        private static const CONFIRM_REJECT:String = 'confirm_reject';

		
		public function connect () :void {
            wrapper.connect();
        }

        public function close () :void {
            wrapper.close();
        }
		
		public function init (host:String, port:uint, path:String) :void {
            wrapper = SocketFactory.newSocketService() 
                .configure(host, port, path)
                .configureListeners(onOpen, onClose, onMessage, onFail)
        }
		
		public function setUserData (data:Object) :void {
            this.userId = data['id'];
            this.heroId = data['hero_id'];
            this.hero_uid = data['hero_uid'];
            this.level = data['level'];
            this.deck_id = data['deck_id'];
        }

		
		 private function onOpen(event:WebSocketEvent):void {
            var msg:Object = {};
            msg['target'] = userId;
            msg['hero_uid'] = hero_uid;
            msg['level'] = level;
            msg['hero_id'] = heroId;
            msg['deck_id'] = deck_id;
            msg['type'] = 'connect_to_lobby';
            msg['status'] = 'success';
            var json:String = JSON.stringify(msg);
            wrapper.send(json);
        }

        private function onClose(event:WebSocketEvent):void {
            trace("Disconnected");
        }

        private function onFail(event:WebSocketErrorEvent):void {
            trace("Connection Failure: " + event.text);
        }

        private function onMessage(event:WebSocketEvent):void {
            if (event.message.type === WebSocketMessage.TYPE_UTF8) {
                var response:Object = JSON.parse(event.message.utf8Data)
                parseResponse(response); 
            } 
            else if (event.message.type === WebSocketMessage.TYPE_BINARY) {
                trace("Got binary message of length " + event.message.binaryData.length);
            }
        }
		
		 private function parseResponse (response:Object) :void {

            var data:Object = {};
            var id:uint;

            switch (response.type) {
                case INIT_PLAYERS:
                {
                    var players:Array = response.data.players;
                    data['players'] = players;
                    dispatch(new LobbyServiceEvent(LobbyServiceEvent.PLAYERS_INIT, data));
                    break;
                }
                case USER_JOIN:
                {
                    id = response.data.id;
                    data['id'] = id;
                    data['hero_uid'] = response.data.hero;
                    data['level'] = response.data.level;
                    dispatch(new LobbyServiceEvent(LobbyServiceEvent.USER_JOIN, data));
                    break;
                }
				case USER_LEAVE:
                {
                     id = response.data.id;
                     data['id'] = id;
                     dispatch(new LobbyServiceEvent(LobbyServiceEvent.USER_LEAVE, data));
                     break;
                }
			}
		 }
		
	}

}