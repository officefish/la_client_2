package com.sla.mvc.view.field.minion.hero {
	import com.sla.mvc.view.field.minion.IMinion;
	import starling.display.DisplayObject;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public interface IHero extends IMinion
	{
		function hideHealth () :void;
		function showHealth () :void;
		function setType(value:int):void;
		function clear():void;
		function stopDarken() :void;
		function setStartHealth(value:int) :void;
		
	}
	
}