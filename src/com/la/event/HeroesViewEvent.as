package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroesViewEvent extends Event 
	{
		
		public static const SELECT:String = 'select';
		private var heroId:int;
		
		public function HeroesViewEvent(type:String, heroId:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.heroId = heroId;
			
		} 
		
		public function getHeroId () :int {
			return heroId;
		}
		
		public override function clone():Event 
		{ 
			return new HeroesViewEvent(type, heroId, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("HeroesViewEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}