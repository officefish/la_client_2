package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class ActionEvent extends Event 
	{
		
		private var initiatorIndex:int;
		private var targetIndex:int;
		
		public static const CLASSIC_ATTACK:String = 'classicAttack';
		
		public function ActionEvent(type:String, initiatorIndex:int, targetIndex:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			this.initiatorIndex = initiatorIndex;
			this.targetIndex = targetIndex;
			super(type, bubbles, cancelable);
			
		}
		
		public function get data () :Object {
			return { 
						'initiatorIndex':initiatorIndex,
						'targetIndex':targetIndex
					}
		}
		
		override public function clone():Event 
		{
			return new ActionEvent (type, initiatorIndex, targetIndex, bubbles, cancelable);
		}
		
	}

}