package com.sla.mvc.view.animation 
{
	import flash.geom.Point;
	import starling.display.DisplayObjectContainer;
	
	/**
	 * ...
	 * @author inozemcev
	 */
	public interface ITargetInitiatorAnimation 
	{
		function configure (container:DisplayObjectContainer, initiatorPosition:Point, targetPosition:Point, onComplete:Function) :void;
		function start () :void;
		function init():void;
	}
	
}