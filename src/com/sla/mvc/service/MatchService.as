package com.sla.mvc.service 
{
	import com.demonsters.debugger.MonsterDebugger;
	import com.la.socket.IWebSocketWrapper;
	import com.la.socket.SocketFactory;
	import com.sla.event.HandEvent;
	import com.sla.event.MatchServiceEvent;
	import com.worlize.websocket.WebSocketErrorEvent;
	import com.worlize.websocket.WebSocketEvent;
	import com.worlize.websocket.WebSocketMessage;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class MatchService extends Actor 
	{
		private static const PREFLOP:String = 'preflop';
        private static const CHANGE_PREFLOP:String = 'change_preflop';
        private static const END_PREFLOP:String = 'end_preflop';
        private static const OPPONENT_PREFLOP_CLICK:String = 'opponent_preflop_click';
        private static const CHANGE_OPPONENT_PREFLOP:String = 'change_opponent_preflop';
        private static const READY:String = 'ready';
        private static const OPPONENT_STEP:String = 'opponent_step';
		private static const PLAYER_STEP:String = 'player_step';
		private static const SCENARIO:String = 'scenario';
		private static const END_STEP_TIMER:String = 'end_step_timer';
		private static const END_MATCH:String = 'end_match'; 
		private static const REPLACE_DECK_ITEMS:String = 'replace_deck_items';
		private static const CURSOR_OVER:String = 'cursor_over';
		private static const CURSOR_OUT:String = 'cursor_out';

		
		private var wrapper:IWebSocketWrapper;
        private var userId:uint;
        private var reconnectFlag:Boolean = false; 
		
		public function MatchService() 
		{
			super();
			
		}
		
		public function init (host:String, port:uint, matchId:int) :void {

            var match_path:String = 'match/' + matchId;

            if (wrapper) {
                wrapper.destroyListeners()
                wrapper.destroy();
            }

            wrapper = SocketFactory.newSocketService()
                    .configure(host, port, match_path)
                    .configureListeners(onOpen, onClose, onMessage, onFail)
        }
		
		 public function setUserData (data:Object) :void {
            this.userId = data['id'];
        }

        public function connect () :void {
            wrapper.connect();
        }

        public function reconnect () :void {
            reconnectFlag = true;
            wrapper.connect();
        }

        public function sendMessage (type:String, data:Object) :void {
            var msg:Object = {}
            msg['target'] = userId;
            msg['type'] = type;
            msg['status'] = 'success';
            msg['data'] = data
            var json:String = JSON.stringify(msg);
            if (wrapper.readyState == 1) {
                wrapper.send(json);
            } else {
               // dispatch(new MatchServiceEvent(MatchServiceEvent.ABORT_CONNECTION, {}))
            }

        }

        public function close () :void {
            wrapper.destroyListeners();
            wrapper.destroy();
            wrapper = null;
        }

        private function onOpen(event:WebSocketEvent):void {


            var msg:Object = {};
            msg['id'] = userId;
            msg['status'] = 'success';

            if (reconnectFlag) {
                reconnectFlag = false;
                msg['type'] = 'reconnect_to_match';
            } else {
                msg['type'] = 'connect_to_match';
            }


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
            MonsterDebugger.log('matchService.onMessage');
			
			if (event.message.type === WebSocketMessage.TYPE_UTF8) {
                var response:Object = JSON.parse(event.message.utf8Data)
                parseResponse(response);
            }
            else if (event.message.type === WebSocketMessage.TYPE_BINARY) {
                trace("Got binary message of length " + event.message.binaryData.length);
            }
        }

        private function parseResponse (response:Object) :void {
            var data:Object = { }
			
			//MonsterDebugger.log(response);
			
			switch (response.type) {
                case PREFLOP:
                {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.CONNECTION_INIT, response.data));
                    break;
                }
				case CHANGE_PREFLOP: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.CHANGE_PREFLOP, response.data));
                    break;
                }
				case END_PREFLOP: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.END_PREFLOP, response.data))
                    break;
                }
				 case CHANGE_OPPONENT_PREFLOP: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.CHANGE_OPPONENT_PREFLOP, response.data))
                    break;
                }
				case OPPONENT_PREFLOP_CLICK: {
                    dispatch(new MatchServiceEvent(MatchServiceEvent.OPPONENT_PREFLOP_CLICK, response.data))
                    break;
                }
				case SCENARIO: {
					dispatch(new MatchServiceEvent(MatchServiceEvent.SCENARIO, response.data))
                    break;
				}
				case END_MATCH: {
					dispatch(new MatchServiceEvent(MatchServiceEvent.END_MATCH, response.data));
					break;
				}
				case CURSOR_OVER: {
					dispatch(new HandEvent(HandEvent.OPPONENT_CURSOR_OVER, response.data));
					break;
				}
				case CURSOR_OUT: {
					dispatch(new HandEvent(HandEvent.OPPONET_CURSOR_OUT, response.data));
					break;
				}
				
				

			}
		}

		
	}

}