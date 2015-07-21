package com.sla.event 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author inozemcev
	 */
	public class LobbyServiceEvent extends DataEvent 
	{
		
		public static const PLAYERS_INIT:String = 'playersInit';
		public static const USER_JOIN:String = 'userJoin';

		public static const INVITE:String = 'invite'
		public static const CONFIRM_SEND_INVITE:String = 'confirmSendInvite';
		public static const CANCEL_INVITE:String = 'cancelInvite';
		public static const CONFIRM_SEND_CANCEL:String = 'confirmSendCancel';
		public static const REJECT_INVITE:String = 'rejectInvite';
		public static const CONFIRM_SEND_REJECT:String = 'confirmSendReject';
		public static const USER_LEAVE:String = 'userLeave';
		public static const ACCEPT_INVITATION:String = 'acceptInvitation';
		
		public function LobbyServiceEvent(type:String, data:Object=null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, data, bubbles, cancelable);
		}
		
		override public function clone():Event 
		{
			return new LobbyServiceEvent(type, data, bubbles, cancelable);
		}
		
	}

}