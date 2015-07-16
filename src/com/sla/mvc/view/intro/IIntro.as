package com.sla.mvc.view.intro 
{
	import flash.events.IEventDispatcher;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public interface IIntro 
	{
		function get asStarlingSprite() :Sprite;
		function resize(stageWidth:int, stageHeight:int) :void;
		function get asEventDispatcher() :IEventDispatcher;
	}
	
}