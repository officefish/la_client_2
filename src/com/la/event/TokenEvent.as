package com.la.event 
{
	import com.la.mvc.view.field.IToken;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class TokenEvent extends Event 
	{
		
		private var token:IToken;
		
		public static const ATTACK:String = 'attack';
		public static const PREVIEW:String = 'preview';
		public static const WIDGET_ACTIVATE_COMPLETE:String = 'widgetActivateComplete';
		
		public function TokenEvent(type:String, token:IToken, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			this.token = token;
			super(type, bubbles, cancelable);
		}
		
		public function getToken () :IToken {
			return token;
		}
		
		public function getTokenDO () :DisplayObject {
			return token as DisplayObject;
		}
		
		override public function clone():Event 
		{
			return new TokenEvent (type, token, bubbles, cancelable);
		}
		
	}

}