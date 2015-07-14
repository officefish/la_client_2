package com.sla.mvc.view.intro 
{
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public interface IIntro 
	{
		function get asStarlingSprite() :Sprite;
		function resize(stageWidth:int, stageHeight:int) :void; 
	}
	
}