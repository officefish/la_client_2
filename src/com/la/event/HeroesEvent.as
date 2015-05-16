package com.la.event 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public class HeroesEvent extends Event 
	{
		
		public static const CHOOSE_HERO_FOR_CRAFT:String = 'chooseHeroForCraft';
		public static const SELECT_HERO:String = 'selectHero';
		private var data:Object;
		
		
		public function HeroesEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.data = data;
			
		} 
		
		public override function clone():Event 
		{ 
			return new HeroesEvent(type, data, bubbles, cancelable);
		} 
		
		public function getData () :Object {
			return data;
		}
		
		public override function toString():String 
		{ 
			return formatToString("HeroesEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}